import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicBrainzService {
  static const String _baseUrl = 'https://musicbrainz.org/ws/2';

  Future<List<Map<String, dynamic>>> searchArtists(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse('$_baseUrl/artist/?query=${Uri.encodeComponent(query)}&fmt=json');
      final response = await http.get(uri, headers: {
        'User-Agent': 'evnttrackr/1.0',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['artists'] != null) {
          final artistsList = data['artists'] as List;
          
          return artistsList.take(5).map((artistJson) {
            final name = artistJson['name'] as String;
            final disambiguation = artistJson['disambiguation'] as String?;
            
            String label = name;
            if (disambiguation != null && disambiguation.isNotEmpty) {
              label = '$name ($disambiguation)';
            }

            return {
              'id': -1, // Use -1 to indicate it's from API, not local DB
              'name': label,
              'originalName': name, // Keep the clean name for saving
            };
          }).toList();
        }
      }
    } catch (e) {
      print('Error searching MusicBrainz artists: $e');
    }
    
    return [];
  }
}
