import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/services/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:evnttrackr/widgets/forms/event_location_field.dart';
import 'package:evnttrackr/widgets/forms/event_datetime_fields.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';

import 'package:evnttrackr/models/event.dart';
import 'package:evnttrackr/models/artist.dart';
import 'package:evnttrackr/models/api_event_result.dart';
import 'package:evnttrackr/services/musicbrainz_service.dart';
import 'package:evnttrackr/widgets/api_attribution_widget.dart';

class CreateEventPage extends ConsumerStatefulWidget {
  final int? eventId;
  final Event? initialEvent;
  final List<Artist>? initialArtists;
  final ApiEventResult? initialApiEvent;

  const CreateEventPage({
    super.key,
    this.eventId,
    this.initialEvent,
    this.initialArtists,
    this.initialApiEvent,
  });

  @override
  ConsumerState<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  
  DatabaseService get _dbService => ref.read(databaseServiceProvider);

  // Event Name
  final _eventNameController = TextEditingController();

  // Location
  int? _selectedLocationId;
  String _confirmedLocationText = '';

  int _selectedTypeIndex = 0;

  // Artists
  final List<Artist> _selectedArtists = [];
  TextEditingController? _artistAutocompleteController;
  int _searchArtistVersion = 0;
  final _mbService = MusicBrainzService();

  // Date and Time
  String? _eventDateTime;
  String? _startDate;
  String? _endDate;
  final GlobalKey<EventLocationFieldState> _locationFieldKey = GlobalKey<EventLocationFieldState>();
  final GlobalKey<EventDateTimeFieldsState> _dateTimeFieldsKey = GlobalKey<EventDateTimeFieldsState>();

  // Ticket
  bool _haveTicket = false;
  final _priceController = TextEditingController();

  bool get _isEditing => widget.eventId != null;

  /// Parses an ISO date string and normalises it to local midnight,
  /// avoiding UTC vs. local-time off-by-one-day assertion failures.
  DateTime _parseLocalDate(String s) {
    final d = DateTime.parse(s);
    return DateTime(d.year, d.month, d.day);
  }

  @override
  void initState() {
    super.initState();
    if (_isEditing && widget.initialEvent != null) {
      final event = widget.initialEvent!;
      _eventNameController.text = event.name;
      _selectedLocationId = event.locationId;
      _confirmedLocationText = event.location ?? '';

      _selectedTypeIndex = event.type - 1;
      _haveTicket = event.gotTicket;
      if (event.price != null) {
        _priceController.text = event.price.toString();
      }

      if (event.type == 2) {
        _eventDateTime = event.date.toIso8601String();
      } else {
        _startDate = event.date.toIso8601String();
        if (event.endDate != null) {
          _endDate = event.endDate!.toIso8601String();
        }
      }

      if (widget.initialArtists != null) {
        _selectedArtists.addAll(widget.initialArtists!);
      }
    } else if (widget.initialApiEvent != null) {
      final api = widget.initialApiEvent!;
      _eventNameController.text = api.name;
      _selectedTypeIndex = api.type - 1;
      
      if (api.locationName != null) {
        _confirmedLocationText = api.locationName!;
      }

      if (api.date != null) {
        if (api.type == 2) {
          _eventDateTime = api.date!.toIso8601String();
        } else {
          _startDate = api.date!.toIso8601String();
        }
      }

      // Add artists with id -1 to indicate they are from API and might need creation
      for (final artistName in api.artists) {
        _selectedArtists.add(Artist(id: -1, name: _toTitleCase(artistName), headliner: false));
      }
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  void _clearForm() {
    setState(() {
      _formKey.currentState?.reset();
      _eventNameController.clear();
      _selectedLocationId = null;
      _confirmedLocationText = '';
      _selectedTypeIndex = 0;
      _selectedArtists.clear();
      _artistAutocompleteController?.clear();
      _eventDateTime = null;
      _startDate = null;
      _endDate = null;
      _haveTicket = false;
      _priceController.clear();
      _locationFieldKey.currentState?.reset();
      _dateTimeFieldsKey.currentState?.reset();
    });
  }

  Future<void> _addAndSelectArtist(String name) async {
    final capitalizedName = _toTitleCase(name);
    try {
      final artistId = await _dbService.createArtist(capitalizedName);
      if (mounted) {
        setState(() {
          _selectedArtists.add(Artist(id: artistId, name: capitalizedName, headliner: false));
        });
      }
    } catch (e) {
      if (mounted) NotificationHelper.showError(context, t.errors.artistAddError);
    }
  }



  Widget _sectionHeader(BuildContext context, IconData icon, String title) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: tt.titleSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child}) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant, width: 0.8),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    InputDecoration fieldDecoration(String label, {IconData? prefixIcon, Widget? suffixIcon}) {
      return InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        filled: true,
      );
    }

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          _isEditing ? t.events.editEvent : t.events.createevent,
          style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded),
              onPressed: _isSaving ? null : _clearForm,
              tooltip: t.common.reset,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.info_outline_rounded, t.events.eventname),
                      TextFormField(
                        controller: _eventNameController,
                        textInputAction: TextInputAction.next,
                        decoration: fieldDecoration(t.events.eventname, prefixIcon: Icons.celebration_rounded),
                        validator: (v) => (v == null || v.isEmpty) ? t.errors.nameRequired : null,
                      ),
                    ],
                  ),
                ),
                _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.location_on_rounded, t.events.location),
                      EventLocationField(
                        key: _locationFieldKey,
                        initialLocationId: _isEditing ? widget.initialEvent?.locationId : null,
                        initialLocationName: _isEditing ? widget.initialEvent?.location : null,
                        onLocationConfirmed: (id, text) {
                          _selectedLocationId = id;
                          _confirmedLocationText = text;
                        },
                      ),
                    ],
                  ),
                ),
                _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.category_rounded, t.events.eventtype),
                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<int>(
                          segments: [
                            ButtonSegment(
                              value: 0,
                              label: Text(t.events.festival),
                              icon: const Icon(Icons.festival_rounded),
                            ),
                            ButtonSegment(
                              value: 1,
                              label: Text(t.events.concert),
                              icon: const Icon(Icons.music_note_rounded),
                            ),
                          ],
                          selected: {_selectedTypeIndex},
                          onSelectionChanged: (Set<int> newSelection) {
                            setState(() => _selectedTypeIndex = newSelection.first);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.calendar_month_rounded, t.events.datetime),
                      EventDateTimeFields(
                        key: _dateTimeFieldsKey,
                        eventTypeIndex: _selectedTypeIndex,
                        initialDateTime: _isEditing && widget.initialEvent?.type == 2 ? widget.initialEvent?.date.toIso8601String() : null,
                        initialStartDate: _isEditing && widget.initialEvent?.type == 1 ? widget.initialEvent?.date.toIso8601String() : null,
                        initialEndDate: _isEditing && widget.initialEvent?.type == 1 ? widget.initialEvent?.endDate?.toIso8601String() : null,
                        onChanged: (dt, start, end) {
                          _eventDateTime = dt;
                          _startDate = start;
                          _endDate = end;
                        },
                      ),
                    ],
                  ),
                ),     _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.people_alt_rounded, t.artists.artists),
                      if (_selectedArtists.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _selectedArtists
                              .map(
                                (artist) => InputChip(
                              label: Text(artist.name),
                              avatar: CircleAvatar(
                                backgroundColor: cs.primaryContainer,
                                child: Text(
                                  artist.name[0].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: cs.onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              onDeleted: () =>
                                  setState(() => _selectedArtists.remove(artist)),
                            ),
                          )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                      Autocomplete<Map<String, dynamic>>(
                        optionsBuilder: (textEditingValue) async {
                          final search = textEditingValue.text.trim();
                          if (search.isEmpty) return [];

                          final currentVersion = ++_searchArtistVersion;
                          await Future.delayed(const Duration(milliseconds: 200));
                          
                          if (currentVersion != _searchArtistVersion) {
                            return [];
                          }

                          final localResponse = await _dbService.searchArtists(search);
                          final localSuggestions = localResponse
                              .map((e) => {'id': e['id'], 'name': e['name'] as String})
                              .toList();

                          final mbSuggestions = await _mbService.searchArtists(search);

                          final List<Map<String, dynamic>> combined = [...localSuggestions, ...mbSuggestions];

                          // Deduplicate by name (case-insensitive)
                          final uniqueSuggestions = <Map<String, dynamic>>[];
                          final seenNames = <String>{};

                          for (var item in combined) {
                            // If it's from MusicBrainz, check the originalName for deduplication
                            final checkName = (item['originalName'] ?? item['name'] as String).toLowerCase();
                            if (!seenNames.contains(checkName)) {
                              seenNames.add(checkName);
                              uniqueSuggestions.add(item);
                            }
                          }

                          if (!uniqueSuggestions.any((s) =>
                          (s['name'] as String).toLowerCase() == search.toLowerCase() ||
                          (s['originalName']?.toLowerCase() == search.toLowerCase()))) {
                            uniqueSuggestions.add({'id': -1, 'name': '+ ${t.common.add} "$search"'});
                          }
                          return uniqueSuggestions;
                        },
                        displayStringForOption: (option) => option['name']!,
                        onSelected: (selection) {
                          if (selection['id'] == -1) {
                            final name = (selection['name'] as String).split('"')[1];
                            _addAndSelectArtist(name);
                          } else if (selection['id'] == -1 && selection.containsKey('originalName')) {
                            // It's a MusicBrainz result, we need to create it
                            _addAndSelectArtist(selection['originalName']);
                          } else {
                            setState(() {
                              if (!_selectedArtists.any((a) => a.id == selection['id'])) {
                                _selectedArtists.add(Artist(
                                  id: selection['id'],
                                  name: selection['name'],
                                  headliner: false,
                                ));
                              }
                            });
                          }
                          _artistAutocompleteController?.clear();
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          _artistAutocompleteController = controller;
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            decoration: fieldDecoration(t.artists.addArtist, prefixIcon: Icons.search_rounded),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                _card(context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(context, Icons.confirmation_number_rounded, t.events.gotmyticket),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(t.events.gotmyticket, style: tt.bodyLarge),
                        value: _haveTicket,
                        onChanged: (value) => setState(() {
                          _haveTicket = value;
                          if (!value) _priceController.clear();
                        }),
                      ),
                      if (_haveTicket) ...[
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _priceController,
                          decoration: fieldDecoration(t.events.priceWithCurrency, prefixIcon: Icons.euro_rounded),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) =>
                          (value != null && value.isNotEmpty && double.tryParse(value.replaceAll(',', '.')) == null)
                              ? t.errors.invalidNumber
                              : null,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: cs.primary,
                      foregroundColor: cs.onPrimary,
                    ),
                    icon: _isSaving
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : Icon(_isEditing ? Icons.save_rounded : Icons.add_circle_rounded),
                    label: Text(
                      _isSaving
                          ? t.events.event_ongoing
                          : (_isEditing ? t.common.update : t.common.create),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: _isSaving
                        ? null
                        : () async {
                      final navigator = Navigator.of(context);


                      if (_formKey.currentState!.validate()) {
                        setState(() => _isSaving = true);
                        _formKey.currentState!.save();
                        try {
                          if (_isEditing) {
                            await _dbService.updateEvent({
                              'p_event_id': widget.eventId,
                              'p_name': _eventNameController.text,
                              'p_location_id': _selectedLocationId,
                              'p_type_id': _selectedTypeIndex + 1,
                              'p_date': _selectedTypeIndex == 1 ? _eventDateTime : _startDate,
                              'p_enddate': _selectedTypeIndex == 1 ? null : _endDate,
                              'p_price': _haveTicket ? double.tryParse(_priceController.text.replaceAll(',', '.')) : null,
                              'p_gotticket': _haveTicket,
                              'p_notes': widget.initialEvent?.notes,
                              'p_artists': _selectedArtists.map((a) => a.toJson()).toList(),
                            });
                          } else {
                            await _dbService.createEvent({
                              'p_name': _eventNameController.text,
                              'p_location': _selectedLocationId,
                              'p_type': _selectedTypeIndex + 1,
                              'p_gotticket': _haveTicket,
                              'p_price': _haveTicket ? double.tryParse(_priceController.text.replaceAll(',', '.')) : null,
                              'p_artists': _selectedArtists.map((a) => a.name).toList(),
                              'p_dates': _selectedTypeIndex == 1
                                  ? [_eventDateTime]
                                  : [_startDate, _endDate],
                            });
                          }
                          if (mounted) {
                            ref.read(eventsRefreshProvider.notifier).state++;
                            if (MainApp.of(context)?.notif1Week == true || MainApp.of(context)?.notif1Day == true) {
                              try {
                                final response = await _dbService.getUpcomingEvents(limit: 50, offset: 0);
                                await LocalNotificationService().syncNotifications(
                                  response,
                                  enable1Week: MainApp.of(context)?.notif1Week ?? false,
                                  enable1Day: MainApp.of(context)?.notif1Day ?? false,
                                );
                              } catch (e) {
                                debugPrint('Erreur lors de la synchro des notifications: $e');
                              }
                            }
                            NotificationHelper.showSuccess(
                              context,
                              _isEditing ? t.events.eventUpdatedSuccess : t.events.eventCreatedSuccess,
                            );
                            if (_isEditing) {
                              navigator.pop(true);
                            } else {
                              _clearForm();
                            }
                          }
                        } catch (e) {
                          debugPrint('Error: $e');
                          if (mounted) {
                            NotificationHelper.showError(
                              context,
                              _isEditing ? t.errors.eventUpdateError : t.errors.eventCreateError,
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isSaving = false);
                          }
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const ApiAttributionWidget(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}