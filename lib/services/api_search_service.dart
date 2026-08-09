import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/api_event_result.dart';
import '../models/event.dart';
import '../services/database_service.dart';
import '../i18n/strings.g.dart';

class ApiSearchService {
  static const String _tmBaseUrl = 'https://app.ticketmaster.com/discovery/v2/events.json';
  static const String _tmApiKey = String.fromEnvironment('TICKETMASTER_API_KEY');
  final DatabaseService _dbService = DatabaseService();

  Future<List<ApiEventResult>> searchEvents(
    String query, {
    DateTime? startDate,
    DateTime? endDate,
    String? genre,
    double? lat,
    double? lng,
    List<String>? providers,
  }) async {
    if (query.trim().isEmpty && lat == null && lng == null) return [];

    try {
      final results = await Future.wait([
        if ((providers == null || providers.contains('EvntTrackr')) && lat == null) _searchLocalEvents(query, startDate, endDate, genre, lat, lng) else Future.value([]),
        if (providers == null || providers.contains('Ticketmaster')) _searchTicketmaster(query, startDate, endDate, genre, lat, lng) else Future.value([]),
        if (providers == null || providers.contains('MusicBrainz')) _searchMusicBrainz(query, startDate, endDate, genre, lat, lng) else Future.value([]),
      ]);

      final localResults = results[0];
      final tmResults = results[1];
      final mbResults = results[2];

      // Merge and deduplicate
      final List<ApiEventResult> merged = [...tmResults];

      for (final mbEvent in mbResults) {
        // Simple deduplication: Check if an event with same date and roughly same location exists
        final isDuplicate = merged.any((tmEvent) {
          if (tmEvent.date == null || mbEvent.date == null) return false;
          final sameDate = tmEvent.date!.year == mbEvent.date!.year &&
                           tmEvent.date!.month == mbEvent.date!.month &&
                           tmEvent.date!.day == mbEvent.date!.day;
          
          if (!sameDate) return false;

          if (tmEvent.locationName == null || mbEvent.locationName == null) return false;
          // Just a basic substring match or exact match for location
          final tmLoc = tmEvent.locationName!.toLowerCase();
          final mbLoc = mbEvent.locationName!.toLowerCase();
          return tmLoc.contains(mbLoc) || mbLoc.contains(tmLoc) || 
                 tmEvent.name.toLowerCase() == mbEvent.name.toLowerCase();
        });

        if (!isDuplicate) {
          merged.add(mbEvent);
        }
      }

      // Sort by date if available
      merged.sort((a, b) {
        if (a.date == null && b.date == null) return 0;
        if (a.date == null) return 1;
        if (b.date == null) return -1;
        return a.date!.compareTo(b.date!);
      });

      // Insert local results at the top
      return [...localResults, ...merged];
    } catch (e) {
      print('Error in searchEvents: $e');
      return [];
    }
  }

  Future<List<ApiEventResult>> _searchLocalEvents(String query, DateTime? startDate, DateTime? endDate, String? genre, double? lat, double? lng) async {
    try {
      dynamic getBaseQuery() {
        var q = Supabase.instance.client
            .from('event')
            .select('id, name, date, type, is_public, "userId", location(label), artist_event:artist_event!band_concert_concertId_fkey(artist:artist!band_concert_bandId_fkey(name))');

        if (query.trim().isNotEmpty) {
          q = q.ilike('name', '%${query.trim()}%');
        }

        // Seulement les événements publics ou ceux de l'utilisateur
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          q = q.or('is_public.eq.true,"userId".eq.$userId');
        } else {
          q = q.eq('is_public', true);
        }
        return q;
      }

      List<dynamic> rawData = [];
      if (startDate != null || endDate != null) {
        var q = getBaseQuery();
        if (startDate != null) {
          q = q.gte('date', startDate.toUtc().toIso8601String());
        }
        if (endDate != null) {
          // End of day
          final end = DateTime.utc(endDate.year, endDate.month, endDate.day, 23, 59, 59);
          q = q.lte('date', end.toIso8601String());
        }
        rawData = await q.order('date', ascending: true).limit(50);
      } else {
        final nowStr = DateTime.now().toUtc().toIso8601String();
        
        final upcomingRes = await getBaseQuery()
            .gte('date', nowStr)
            .order('date', ascending: true)
            .limit(30);
            
        final pastRes = await getBaseQuery()
            .lt('date', nowStr)
            .order('date', ascending: false)
            .limit(20);
            
        rawData = [...upcomingRes, ...pastRes];
      }
      final List<ApiEventResult> matchedLocal = [];

      for (final row in rawData) {
        final id = row['id'];
        final name = row['name'];
        final date = row['date'] != null ? DateTime.tryParse(row['date']) : null;
        final type = row['type'] ?? 1;
        
        String locationName = t.events.unknownLocation;
        if (row['location'] != null && row['location'] is Map) {
          locationName = row['location']['label'] ?? t.events.unknownLocation;
        }

        final List<String> artistsList = [];
        if (row['artist_event'] != null && row['artist_event'] is List) {
          for (final ae in row['artist_event']) {
            if (ae['artist'] != null && ae['artist']['name'] != null) {
              artistsList.add(ae['artist']['name']);
            }
          }
        }

        matchedLocal.add(ApiEventResult(
          apiId: 'local_$id',
          name: name,
          date: date,
          locationName: locationName,
          artists: artistsList,
          type: type,
          provider: 'EvntTrackr',
        ));
      }
      
      return matchedLocal;
    } catch (e) {
      print('Error searching local events directly: $e');
      return [];
    }
  }

  Future<List<ApiEventResult>> _searchTicketmaster(String query, DateTime? startDate, DateTime? endDate, String? genre, double? lat, double? lng) async {
    if (_tmApiKey.isEmpty) {
      print('WARNING: TICKETMASTER_API_KEY is not set. Ticketmaster search will not work.');
      return [];
    }

    try {
      String url = '$_tmBaseUrl?apikey=$_tmApiKey&size=20&sort=date,asc';
      
      if (query.trim().isNotEmpty) {
        url += '&keyword=${Uri.encodeComponent(query)}';
      }
      
      if (genre != null) {
        url += '&classificationName=${Uri.encodeComponent(genre)}';
      } else {
        url += '&classificationName=Music';
      }

      if (lat != null && lng != null) {
        url += '&latlong=$lat,$lng&radius=50&unit=km';
      }
      
      final actualStartDate = startDate ?? DateTime.now();
      url += '&startDateTime=${actualStartDate.toUtc().toIso8601String().split('.')[0]}Z';
      
      if (endDate != null) {
        // End of the selected day
        final end = DateTime.utc(endDate.year, endDate.month, endDate.day, 23, 59, 59);
        url += '&endDateTime=${end.toIso8601String().split('.')[0]}Z';
      }

      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['_embedded'] != null && data['_embedded']['events'] != null) {
          final eventsJson = data['_embedded']['events'] as List;
          
          return eventsJson.map((eventJson) {
            final apiId = eventJson['id'] as String;
            final name = eventJson['name'] as String;
            
            DateTime? date;
            if (eventJson['dates'] != null && eventJson['dates']['start'] != null) {
              final start = eventJson['dates']['start'];
              if (start['dateTime'] != null) {
                date = DateTime.tryParse(start['dateTime']);
              } else if (start['localDate'] != null) {
                date = DateTime.tryParse(start['localDate']);
              }
            }

            String? locationName;
            if (eventJson['_embedded'] != null && eventJson['_embedded']['venues'] != null) {
              final venues = eventJson['_embedded']['venues'] as List;
              if (venues.isNotEmpty) {
                locationName = venues[0]['name'] as String?;
              }
            }

            List<String> artists = [];
            if (eventJson['_embedded'] != null && eventJson['_embedded']['attractions'] != null) {
              final attractions = eventJson['_embedded']['attractions'] as List;
              artists = attractions.map((a) => a['name'] as String).toList();
            }
            
            int type = 1; 
            if (name.toLowerCase().contains('festival') || name.toLowerCase().contains('fest')) {
              type = 2; 
            }

            return ApiEventResult(
              apiId: apiId,
              name: name,
              date: date,
              locationName: locationName,
              artists: artists,
              type: type,
              provider: 'Ticketmaster',
            );
          }).toList();
        }
      }
    } catch (e) {
      print('Error searching Ticketmaster: $e');
    }
    return [];
  }

  Future<List<ApiEventResult>> _searchMusicBrainz(String query, DateTime? startDate, DateTime? endDate, String? genre, double? lat, double? lng) async {
    // MusicBrainz doesn't support lat/long natively, skip if location search is active
    if (lat != null && lng != null) return [];
    if (query.trim().isEmpty) return [];

    try {
      String mbQuery = query;
      if (genre != null) {
        mbQuery += ' AND tag:${genre.toLowerCase()}';
      }

      final uri = Uri.parse('https://musicbrainz.org/ws/2/event/?query=${Uri.encodeComponent(mbQuery)}&fmt=json');
      final response = await http.get(uri, headers: {
        'User-Agent': 'evnttrackr/1.0',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['events'] != null) {
          final eventsList = data['events'] as List;
          
          return eventsList.map((eventJson) {
            final apiId = eventJson['id'] as String;
            final name = eventJson['name'] as String;
            
            DateTime? date;
            if (eventJson['life-span'] != null && eventJson['life-span']['begin'] != null) {
              date = DateTime.tryParse(eventJson['life-span']['begin']);
            }

            String? locationName;
            List<String> artists = [];

            if (eventJson['relations'] != null) {
              final relations = eventJson['relations'] as List;
              for (final rel in relations) {
                if (rel['type'] == 'held at' && rel['place'] != null) {
                  locationName = rel['place']['name'];
                }
                if ((rel['type'] == 'main performer' || rel['type'] == 'support act') && rel['artist'] != null) {
                  artists.add(rel['artist']['name']);
                }
              }
            }

            int type = 1; 
            if (eventJson['type'] == 'Festival' || name.toLowerCase().contains('festival') || name.toLowerCase().contains('fest')) {
              type = 2; 
            }

            return ApiEventResult(
              apiId: apiId,
              name: name,
              date: date,
              locationName: locationName,
              artists: artists,
              type: type,
              provider: 'MusicBrainz',
            );
          }).where((event) {
            if (event.date == null) return false;
            
            final actualStartDate = startDate ?? DateTime.now();
            bool isAfterStart = event.date!.isAfter(actualStartDate.subtract(const Duration(days: 1)));
            bool isBeforeEnd = endDate == null || event.date!.isBefore(endDate.add(const Duration(days: 1)));
            
            return isAfterStart && isBeforeEnd;
          }).toList();
        }
      }
    } catch (e) {
      print('Error searching MusicBrainz events: $e');
    }
    return [];
  }
}
