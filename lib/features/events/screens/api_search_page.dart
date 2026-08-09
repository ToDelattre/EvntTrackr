import 'dart:async';
import 'package:flutter/material.dart';
import 'package:evnttrackr/services/api_search_service.dart';
import 'package:evnttrackr/models/api_event_result.dart';
import 'package:evnttrackr/features/events/screens/create_event_page.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:evnttrackr/widgets/api_attribution_widget.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class ApiSearchPage extends StatefulWidget {
  const ApiSearchPage({super.key});

  @override
  State<ApiSearchPage> createState() => _ApiSearchPageState();
}

class _ApiSearchPageState extends State<ApiSearchPage> {
  final _searchController = TextEditingController();
  final _apiService = ApiSearchService();
  
  List<ApiEventResult> _results = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  Timer? _debounce;
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _selectedProviders = ['EvntTrackr', 'Ticketmaster', 'MusicBrainz'];
  String? _selectedGenre;
  bool _isLocationActive = false;
  double? _lat;
  double? _lng;
  final List<String> _genres = ['Rock', 'Metal', 'Pop', 'Hip-Hop', 'Electronic', 'Jazz', 'Classical', 'Country'];

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty || _selectedGenre != null || _isLocationActive) {
        _performSearch(query);
      } else {
        setState(() {
          _results = [];
          _hasSearched = false;
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final results = await _apiService.searchEvents(
        query, 
        startDate: _startDate, 
        endDate: _endDate,
        genre: _selectedGenre,
        lat: _lat,
        lng: _lng,
        providers: _selectedProviders,
      );
      if (mounted) {
        setState(() {
          _results = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToCreatePage({ApiEventResult? apiEvent}) {
    if (apiEvent != null && apiEvent.provider == 'EvntTrackr') {
      final id = int.parse(apiEvent.apiId.split('_')[1]);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CreateEventPage(eventId: id),
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CreateEventPage(initialApiEvent: apiEvent),
      ),
    );
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez activer la localisation.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permissions refusées.')));
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permissions refusées définitivement.')));
      return;
    } 

    setState(() => _isLoading = true);
    try {
      Position? position = await Geolocator.getLastKnownPosition();
      if (position == null) {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          timeLimit: const Duration(seconds: 5),
        );
      }
      setState(() {
        _lat = position!.latitude;
        _lng = position.longitude;
        _isLocationActive = true;
      });
      _onSearchChanged(_searchController.text);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de la localisation ou délai dépassé.')));
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      if (_searchController.text.isNotEmpty) {
        _performSearch(_searchController.text);
      }
    }
  }

  void _showProvidersModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sources de données', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 16),
                    ...['EvntTrackr', 'Ticketmaster', 'MusicBrainz'].map((provider) {
                      return CheckboxListTile(
                        title: Text(provider),
                        value: _selectedProviders.contains(provider),
                        onChanged: (bool? checked) {
                          setModalState(() {
                            if (checked == true) {
                              if (!_selectedProviders.contains(provider)) _selectedProviders.add(provider);
                            } else {
                              _selectedProviders.remove(provider);
                            }
                          });
                        },
                      );
                    }),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                          if (_searchController.text.isNotEmpty || _isLocationActive) {
                            _performSearch(_searchController.text);
                          }
                        },
                        child: const Text('Appliquer'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          t.events.searchOnlineTitle,
          style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: t.events.searchPlaceholder,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: cs.surfaceContainerHighest.withOpacity(0.3),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Provider Filter
                    ActionChip(
                      avatar: const Icon(Icons.source_rounded, size: 16),
                      label: Text(_selectedProviders.length == 3 ? 'Toutes les sources' : '${_selectedProviders.length} sources'),
                      onPressed: _showProvidersModal,
                      backgroundColor: _selectedProviders.length < 3 ? Theme.of(context).colorScheme.primaryContainer : null,
                      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    const SizedBox(width: 8),

                    // Location Filter
                    ActionChip(
                      avatar: const Icon(Icons.location_on_rounded, size: 16),
                      label: Text(t.events.filterAroundMe),
                      onPressed: () {
                        if (_isLocationActive) {
                          setState(() { _isLocationActive = false; _lat = null; _lng = null; });
                          _onSearchChanged(_searchController.text);
                        } else {
                          _getLocation();
                        }
                      },
                      backgroundColor: _isLocationActive ? cs.primaryContainer : null,
                      side: BorderSide(color: cs.outlineVariant),
                    ),
                    if (_isLocationActive) ...[
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          setState(() { _isLocationActive = false; _lat = null; _lng = null; });
                          _onSearchChanged(_searchController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.close_rounded, size: 20, color: cs.onSurfaceVariant),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),

                    // Genre Filter
                    ActionChip(
                      avatar: const Icon(Icons.music_note_rounded, size: 16),
                      label: Text(_selectedGenre ?? t.events.filterGenre),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView(
                              shrinkWrap: true,
                              children: _genres.map((genre) => ListTile(
                                title: Text(genre),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() => _selectedGenre = genre);
                                  _onSearchChanged(_searchController.text);
                                },
                              )).toList(),
                            );
                          },
                        );
                      },
                      backgroundColor: _selectedGenre != null ? cs.primaryContainer : null,
                      side: BorderSide(color: cs.outlineVariant),
                    ),
                    if (_selectedGenre != null) ...[
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          setState(() => _selectedGenre = null);
                          _onSearchChanged(_searchController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.close_rounded, size: 20, color: cs.onSurfaceVariant),
                        ),
                      ),
                    ],
                    const SizedBox(width: 8),

                    // Date Filter
                    ActionChip(
                    avatar: const Icon(Icons.date_range_rounded, size: 16),
                    label: Text(_startDate != null 
                        ? '${DateFormat.MMMd().format(_startDate!)} - ${DateFormat.MMMd().format(_endDate!)}' 
                        : t.events.filterDate),
                    onPressed: _selectDateRange,
                    backgroundColor: _startDate != null ? cs.primaryContainer : null,
                    side: BorderSide(color: cs.outlineVariant),
                  ),
                  if (_startDate != null) ...[
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _startDate = null;
                          _endDate = null;
                        });
                        if (_searchController.text.isNotEmpty) {
                          _performSearch(_searchController.text);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.close_rounded, size: 20, color: cs.onSurfaceVariant),
                      ),
                    ),
                  ],
                  ],
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _navigateToCreatePage(),
                icon: const Icon(Icons.edit_rounded),
                label: Text(t.events.createManually),
              ),
            ),
          ),
          
          const SizedBox(height: 16),

          Expanded(
            child: _buildResultsList(cs, tt),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: cs.tertiaryContainer.withOpacity(0.5),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 16, color: cs.onTertiaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    t.events.searchBetaDesc,
                    style: TextStyle(fontSize: 12, color: cs.onTertiaryContainer),
                  ),
                ),
              ],
            ),
          ),
          const ApiAttributionWidget(),
        ],
      ),
    );
  }

  Widget _buildResultsList(ColorScheme cs, TextTheme tt) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasSearched && _results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 64, color: cs.onSurfaceVariant.withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              t.events.noEventDetailsFound,
              style: tt.titleMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                t.events.noEventDetailsFoundDesc,
                textAlign: TextAlign.center,
                style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _navigateToCreatePage(),
              icon: const Icon(Icons.add_rounded),
              label: Text(t.events.createManually),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (context, index) => Divider(height: 1, indent: 16, endIndent: 16, color: cs.outlineVariant.withOpacity(0.5)),
      itemBuilder: (context, index) {
        final result = _results[index];
        final dateStr = result.date != null 
            ? DateFormat.yMMMd().format(result.date!) 
            : '';
            
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: CircleAvatar(
            backgroundColor: cs.primaryContainer,
            child: Icon(
              result.type == 2 ? Icons.festival_rounded : Icons.music_note_rounded,
              color: cs.onPrimaryContainer,
            ),
          ),
          title: Text(
            result.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                [
                  if (dateStr.isNotEmpty) dateStr,
                  if (result.locationName != null) result.locationName,
                ].join(' • '),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (result.artists.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.people_alt_rounded, size: 14, color: cs.primary),
                    const SizedBox(width: 4),
                    Text(
                      '${result.artists.length} ${result.artists.length > 1 ? t.events.artistsIncluded : t.events.artistIncluded}',
                      style: TextStyle(
                        fontSize: 12,
                        color: cs.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: result.provider == 'EvntTrackr' ? cs.primary : cs.secondaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (result.provider == 'EvntTrackr') ...[
                  Icon(Icons.star_rounded, size: 12, color: cs.onPrimary),
                  const SizedBox(width: 4),
                ],
                Text(
                  result.provider,
                  style: TextStyle(
                    fontSize: 10,
                    color: result.provider == 'EvntTrackr' ? cs.onPrimary : cs.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          onTap: () => _navigateToCreatePage(apiEvent: result),
        );
      },
    );
  }
}
