import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/services/local_notification_service.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

import 'package:evnttrackr/features/events/screens/create_event_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';

import 'package:evnttrackr/models/event.dart';
import 'package:evnttrackr/models/artist.dart';

enum ArtistSortOrder { headliner, aToZ, zToA }

extension ArtistSortOrderExtension on ArtistSortOrder {
  String name(BuildContext context) {
    switch (this) {
      case ArtistSortOrder.headliner:
        return t.artists.artistSortOrderHeadliner;
      case ArtistSortOrder.aToZ:
        return t.artists.artistSortOrderAZ;
      case ArtistSortOrder.zToA:
        return t.artists.artistSortOrderZA;
    }
  }
}

class EventDetailsPage extends ConsumerStatefulWidget {
  final int eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ConsumerState<EventDetailsPage> {
  bool _isLoading = true;
  String? _error;
  Event? _event;
  List<Artist> _artists = [];
  List<Artist> _paginatedArtists = [];
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  // Sorting and pagination state
  ArtistSortOrder _sortOrder = ArtistSortOrder.headliner;
  int _currentPage = 1;
  final int _artistsPerPage = 10;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _fetchEventDetails();
  }

  Future<void> _fetchEventDetails() async {
    try {
      final eventResponse = await _dbService.getEventById(widget.eventId);
      final event = Event.fromJson(eventResponse);

      final artistsResponse =
      await _dbService.getArtistsByEvents([widget.eventId]);
      final artists =
      artistsResponse.map((json) => Artist.fromJson(json)).toList();

      if (mounted) {
        setState(() {
          _event = event;
          _artists = artists;
          _sortAndPaginateArtists();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _sortAndPaginateArtists() {
    List<Artist> sorted = List.from(_artists);
    switch (_sortOrder) {
      case ArtistSortOrder.headliner:
        sorted.sort((a, b) {
          if (a.headliner && !b.headliner) return -1;
          if (!a.headliner && b.headliner) return 1;
          return a.name.compareTo(b.name);
        });
        break;
      case ArtistSortOrder.aToZ:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ArtistSortOrder.zToA:
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
    }

    _totalPages = (sorted.length / _artistsPerPage).ceil();
    if (_currentPage > _totalPages) _currentPage = _totalPages;
    if (_currentPage < 1) _currentPage = 1;

    final int start = (_currentPage - 1) * _artistsPerPage;
    final int end = start + _artistsPerPage;
    _paginatedArtists = sorted.sublist(
      start,
      end > sorted.length ? sorted.length : end,
    );
  }

  Future<void> _deleteEvent() async {
    try {
      await _dbService.deleteEvent(widget.eventId);
      await LocalNotificationService().cancelEventNotifications(widget.eventId);
      if (mounted) {
        ref.read(eventsRefreshProvider.notifier).state++;
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        NotificationHelper.showError(context, t.errors.errorDeletingEvent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text("${t.errors.error}: $_error")));
    }

    if (_event == null) {
      return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text(t.events.noEventDetailsFound)));
    }

    final Event event = _event!;
    final bool isFestival = event.type == 1;
    final IconData eventIcon =
    isFestival ? Icons.festival_rounded : Icons.music_note_rounded;

    final locale = LocaleSettings.currentLocale.languageCode;
    final dateFormat =
    isFestival ? DateFormat.yMd(locale) : DateFormat.yMd(locale).add_Hm();

    final startDateFormatted = dateFormat.format(event.date);
    final endDateFormatted =
    event.endDate != null ? dateFormat.format(event.endDate!) : '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_calendar_rounded),
            tooltip: t.events.editevent,
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateEventPage(
                    eventId: event.id,
                    initialEvent: event,
                    initialArtists: _artists,
                  ),
                ),
              );
              if (result == true) {
                _fetchEventDetails();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever_rounded),
            tooltip: t.events.deleteEvent,
            onPressed: () => _showDeleteConfirmationDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(eventIcon,
                    size: 40, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(event.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfoSection(
                context, event, startDateFormatted, endDateFormatted),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(t.artists.artists,
                    style: Theme.of(context).textTheme.headlineSmall),
                if (_artists.isNotEmpty)
                  DropdownButton<ArtistSortOrder>(
                    value: _sortOrder,
                    underline: const SizedBox(),
                    items: ArtistSortOrder.values.map((order) {
                      return DropdownMenuItem(
                        value: order,
                        child: Text(order.name(context)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _sortOrder = value;
                          _currentPage = 1;
                          _sortAndPaginateArtists();
                        });
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (_artists.isEmpty)
              Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(t.artists.noArtistsForEvent),
                  ))
            else
              ..._paginatedArtists.map((artist) {
                final hasRating = artist.rating != null ||
                    artist.soundRating != null ||
                    artist.setlistRating != null;
                final hasNotes =
                    artist.notes != null && artist.notes!.trim().isNotEmpty;

                IconData statusIcon = Icons.rate_review_rounded;
                if (hasRating && hasNotes) {
                  statusIcon = Icons.fact_check_rounded;
                } else if (hasRating || hasNotes) {
                  statusIcon = Icons.check_circle_rounded;
                }

                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(artist.headliner
                          ? Icons.stars_rounded
                          : Icons.stars_outlined),
                      color: artist.headliner
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      tooltip: t.artists.headliner,
                      onPressed: () async {
                        final bool originalValue = artist.headliner;



                        // Optimistic update
                        setState(() {
                          artist.headliner = !originalValue;
                          _sortAndPaginateArtists();
                        });

                        try {
                          await _dbService.toggleArtistHeadliner(
                              event.id, artist.id);
                          ref.read(eventsRefreshProvider.notifier).state++;
                        } catch (error) {
                          if (!mounted) return;

                          setState(() {
                            artist.headliner = originalValue;
                            _sortAndPaginateArtists();
                          });

                          NotificationHelper.showError(
                              context, t.errors.errorUpdatingHeadlinerStatus);
                        }
                      },
                    ),
                    title: Text(artist.name,
                        style:
                        const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(statusIcon, color: Theme.of(context).colorScheme.primary),
                          tooltip: t.artists.rateArtist,
                          onPressed: () {
                            _showRateArtistBottomSheet(context, artist);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            if (_totalPages > 1)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_rounded),
                      onPressed: _currentPage > 1
                          ? () {
                        setState(() {
                          _currentPage--;
                          _sortAndPaginateArtists();
                        });
                      }
                          : null,
                    ),
                    Text(t.common.pageOutOfTotal(
                        currentPage: _currentPage,
                        totalPages: _totalPages)),
                    IconButton(
                      icon: const Icon(Icons.chevron_right_rounded),
                      onPressed: _currentPage < _totalPages
                          ? () {
                        setState(() {
                          _currentPage++;
                          _sortAndPaginateArtists();
                        });
                      }
                          : null,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                t.events.confirmDeletion,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                t.events.confirmDeleteEventMessage,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text(t.common.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(t.common.delete),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _deleteEvent();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ Fully synchronous — no async gap, no BuildContext-across-await warning
  void _showRateArtistBottomSheet(BuildContext context, Artist artist) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return _RateArtistContent(
          artist: artist,
          eventId: _event!.id,
          onSave: (perf, setl, snd, nts) {
            if (mounted) {
              setState(() {
                artist.rating = perf;
                artist.setlistRating = setl;
                artist.soundRating = snd;
                artist.notes = nts;
              });
            }
          },
        );
      },
    );
  }

  Widget _buildInfoSection(
      BuildContext context, Event event, String startDate, String endDate) {
    final currencyFormat = NumberFormat.simpleCurrency(
        locale: LocaleSettings.currentLocale.languageCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (event.location != null && event.location!.isNotEmpty)
          _buildInfoRow(context, Icons.location_on_rounded, event.location!),
        _buildInfoRow(
            context,
            Icons.calendar_today_rounded,
            event.endDate != null
                ? t.common.dateRange(startDate: startDate, endDate: endDate)
                : startDate),
        if (event.price != null)
          _buildInfoRow(context, Icons.euro_symbol_rounded,
              currencyFormat.format(event.price)),
        if (event.notes != null && event.notes!.isNotEmpty)
          _buildInfoRow(context, Icons.notes_rounded, event.notes!),
      ]
          .map((widget) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0), child: widget))
          .toList(),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon,
            color: Theme.of(context).textTheme.bodySmall?.color, size: 20),
        const SizedBox(width: 16),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _RateArtistContent — owns its own data loading to avoid BuildContext leaks
// ---------------------------------------------------------------------------

class _RateArtistContent extends ConsumerStatefulWidget {
  final Artist artist;
  final int eventId;
  final Function(double?, double?, double?, String?) onSave;

  const _RateArtistContent({
    required this.artist,
    required this.eventId,
    required this.onSave,
  });

  @override
  ConsumerState<_RateArtistContent> createState() => _RateArtistContentState();
}

class _RateArtistContentState extends ConsumerState<_RateArtistContent> {
  double performance = 0.0;
  double setlist = 0.0;
  double sound = 0.0;
  late TextEditingController notesController;
  bool _isLoading = true;
  String? _loadError;
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController();
    _loadRatings();
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  Future<void> _loadRatings() async {
    try {
      final ratings = await _dbService.getArtistEventRatings(
        widget.eventId,
        widget.artist.id,
      );
      if (!mounted) return;
      final data =
      ratings.isNotEmpty ? ratings.first as Map<String, dynamic> : {};
      setState(() {
        performance = (data['rating'] as num?)?.toDouble() ?? 0.0;
        setlist = (data['setlist_rating'] as num?)?.toDouble() ?? 0.0;
        sound = (data['sound_rating'] as num?)?.toDouble() ?? 0.0;
        notesController.text = data['notes'] as String? ?? '';
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadError = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_loadError != null) {
      return SizedBox(
        height: 200,
        child: Center(child: Text(t.errors.error)),
      );
    }

    Widget buildRatingSlider(
        String label, double value, Function(double) onChanged) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(value.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value,
            min: 0,
            max: 5,
            divisions: 10,
            label: value.toString(),
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (double val) {
              setState(() {
                onChanged(val);
              });
            },
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "${t.artists.rateArtist}: ${widget.artist.name}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon:
                const Icon(Icons.refresh_rounded, color: AppColors.warning),
                tooltip: t.common.reset,
                onPressed: () async {
                  // ✅ Capture context-dependents before the await
                  final navigator = Navigator.of(context);


                  try {
                    await _dbService.updateArtistEventRatings(
                      artistId: widget.artist.id,
                      eventId: widget.eventId,
                      rating: null,
                      setlist: null,
                      sound: null,
                      notes: null,
                    );

                    widget.onSave(null, null, null, null);
                    ref.read(eventsRefreshProvider.notifier).state++;

                    if (mounted) {
                      NotificationHelper.showSuccess(context, t.artists.ratingSaved);
                      navigator.pop();
                    }
                  } catch (e) {
                    debugPrint('Error resetting ratings: $e');
                    if (mounted) {
                      NotificationHelper.showError(context, t.errors.error);
                    }
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          buildRatingSlider(t.artists.performanceRating, performance,
                  (val) => performance = val),
          buildRatingSlider(
              t.artists.setlistRatingLabel, setlist, (val) => setlist = val),
          buildRatingSlider(
              t.artists.soundQualityRating, sound, (val) => sound = val),
          const SizedBox(height: 16),
          TextField(
            controller: notesController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: t.artists.globalReview,
              alignLabelWithHint: true,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(t.common.cancel),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);


                  final String? finalNotes = notesController.text.trim().isEmpty
                      ? null
                      : notesController.text.trim();

                  try {
                    await _dbService.updateArtistEventRatings(
                      artistId: widget.artist.id,
                      eventId: widget.eventId,
                      rating: performance,
                      setlist: setlist,
                      sound: sound,
                      notes: finalNotes,
                    );

                    widget.onSave(performance, setlist, sound, finalNotes);
                    ref.read(eventsRefreshProvider.notifier).state++;

                    if (mounted) {
                      NotificationHelper.showSuccess(context, t.artists.ratingSaved);
                      navigator.pop();
                    }
                  } catch (e) {
                    debugPrint('Error saving ratings: $e');
                    if (mounted) {
                      NotificationHelper.showError(context, t.errors.error);
                    }
                  }
                },
                child: Text(t.common.save),
              ),
            ],
          ),
        ],
      ),
    );
  }
}