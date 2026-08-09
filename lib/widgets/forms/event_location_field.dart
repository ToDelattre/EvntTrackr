import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/services/osm_service.dart';

class EventLocationField extends ConsumerStatefulWidget {
  final int? initialLocationId;
  final String? initialLocationName;
  final Function(int? id, String name) onLocationConfirmed;

  const EventLocationField({
    super.key,
    this.initialLocationId,
    this.initialLocationName,
    required this.onLocationConfirmed,
  });

  @override
  ConsumerState<EventLocationField> createState() => EventLocationFieldState();
}

class EventLocationFieldState extends ConsumerState<EventLocationField> {
  DatabaseService get _dbService => ref.read(databaseServiceProvider);
  int? selectedLocationId;
  bool locationConfirmed = false;
  String confirmedLocationText = '';
  late TextEditingController _controller;
  final _osmService = OSMService();
  int _searchVersion = 0;

  @override
  void initState() {
    super.initState();
    selectedLocationId = widget.initialLocationId;
    if (widget.initialLocationName != null && widget.initialLocationName!.isNotEmpty) {
      confirmedLocationText = widget.initialLocationName!;
      locationConfirmed = true;
    }
  }

  void reset() {
    setState(() {
      selectedLocationId = null;
      locationConfirmed = false;
      confirmedLocationText = '';
      _controller.clear();
    });
    widget.onLocationConfirmed(null, '');
  }

  Future<void> _addAndSelectLocation(String label) async {
    final capitalizedLabel = _toTitleCase(label);
    try {
      final locationId = await _dbService.createLocation(capitalizedLabel);
      if (mounted) {
        setState(() {
          selectedLocationId = locationId;
          locationConfirmed = true;
          confirmedLocationText = capitalizedLabel;
          _controller.text = capitalizedLabel;
        });
        widget.onLocationConfirmed(selectedLocationId, confirmedLocationText);
      }
    } catch (e) {
      // Ignore
    }
  }

  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Autocomplete<Map<String, dynamic>>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final searchText = textEditingValue.text.trim();
        if (searchText.isEmpty) return const [];

        final currentVersion = ++_searchVersion;
        await Future.delayed(const Duration(milliseconds: 200));
        
        if (currentVersion != _searchVersion) {
          return const [];
        }

        final localResponse = await _dbService.searchLocations(searchText);
        final localSuggestions = localResponse
            .map((item) => {'id': item['id'], 'label': item['label'] as String})
            .toList();

        final osmSuggestions = await _osmService.searchLocations(searchText);

        final List<Map<String, dynamic>> combined = [...localSuggestions, ...osmSuggestions];

        // Deduplicate by label (case-insensitive)
        final uniqueSuggestions = <Map<String, dynamic>>[];
        final seenLabels = <String>{};

        for (var item in combined) {
          final lowerLabel = (item['label'] as String).toLowerCase();
          if (!seenLabels.contains(lowerLabel)) {
            seenLabels.add(lowerLabel);
            uniqueSuggestions.add(item);
          }
        }

        if (!uniqueSuggestions.any((s) => (s['label'] as String).toLowerCase() == searchText.toLowerCase())) {
          uniqueSuggestions.add({'id': -1, 'label': '+ ${t.common.add} "$searchText"'});
        }
        
        return uniqueSuggestions;
      },
      displayStringForOption: (option) => option['label'],
      onSelected: (Map<String, dynamic> selection) {
        if (selection['id'] == -1) {
          final label = (selection['label'] as String).split('"')[1];
          _addAndSelectLocation(label);
        } else {
          setState(() {
            selectedLocationId = selection['id'];
            locationConfirmed = true;
            confirmedLocationText = selection['label'];
            _controller.text = selection['label'];
          });
          widget.onLocationConfirmed(selectedLocationId, confirmedLocationText);
        }
      },
      initialValue: TextEditingValue(text: confirmedLocationText),
      fieldViewBuilder: (context, fieldController, fieldFocusNode, onFieldSubmitted) {
        _controller = fieldController;
        return TextFormField(
          controller: fieldController,
          focusNode: fieldFocusNode,
          onChanged: (value) {
            if (locationConfirmed && value != confirmedLocationText) {
              setState(() {
                locationConfirmed = false;
                selectedLocationId = null;
              });
              widget.onLocationConfirmed(null, value);
            }
          },
          decoration: InputDecoration(
            labelText: t.events.location,
            prefixIcon: const Icon(Icons.place_rounded),
            suffixIcon: locationConfirmed
                ? Icon(Icons.check_circle_rounded, color: cs.tertiary)
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
            filled: true,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return t.errors.locationRequired;
            // The bug fix: If locationConfirmed is true, we accept it even if ID is null (for older events)
            if (!locationConfirmed) return t.errors.locationRequired;
            return null;
          },
        );
      },
    );
  }
}
