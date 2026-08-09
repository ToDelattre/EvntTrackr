import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class EventDateTimeFields extends StatefulWidget {
  final int eventTypeIndex; // 0 = Festival, 1 = Concert
  final String? initialDateTime;
  final String? initialStartDate;
  final String? initialEndDate;
  final Function(String? dateTime, String? startDate, String? endDate) onChanged;

  const EventDateTimeFields({
    super.key,
    required this.eventTypeIndex,
    this.initialDateTime,
    this.initialStartDate,
    this.initialEndDate,
    required this.onChanged,
  });

  @override
  State<EventDateTimeFields> createState() => EventDateTimeFieldsState();
}

class EventDateTimeFieldsState extends State<EventDateTimeFields> {
  String? _eventDateTime;
  String? _startDate;
  String? _endDate;

  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eventDateTime = widget.initialDateTime;
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _updateControllers();
  }
  
  @override
  void didUpdateWidget(covariant EventDateTimeFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.eventTypeIndex != widget.eventTypeIndex) {
      _notifyChanges();
    }
  }

  void _updateControllers() {
    if (_eventDateTime != null) {
      final dt = DateTime.parse(_eventDateTime!);
      _dateTimeController.text = DateFormat('dd/MM/yyyy HH:mm').format(dt);
    }
    if (_startDate != null) {
      final d = DateTime.parse(_startDate!);
      _startDateController.text = DateFormat('dd/MM/yyyy').format(d);
    }
    if (_endDate != null) {
      final d = DateTime.parse(_endDate!);
      _endDateController.text = DateFormat('dd/MM/yyyy').format(d);
    }
  }

  void reset() {
    setState(() {
      _eventDateTime = null;
      _startDate = null;
      _endDate = null;
      _dateTimeController.clear();
      _startDateController.clear();
      _endDateController.clear();
    });
    _notifyChanges();
  }

  void _notifyChanges() {
    widget.onChanged(_eventDateTime, _startDate, _endDate);
  }

  DateTime _parseLocalDate(String s) {
    final d = DateTime.parse(s);
    return DateTime(d.year, d.month, d.day);
  }

  InputDecoration _fieldDecoration(BuildContext context, String label) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      filled: true,
      suffixIcon: Icon(Icons.event_rounded, color: cs.primary),
    );
  }

  Future<void> _pickDateTime() async {
    final initialDate = _eventDateTime != null ? DateTime.parse(_eventDateTime!) : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (time != null) {
        final dt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
        setState(() {
          _eventDateTime = dt.toIso8601String();
          _dateTimeController.text = DateFormat('dd/MM/yyyy HH:mm').format(dt);
        });
        _notifyChanges();
      }
    }
  }

  Future<void> _pickStartDate() async {
    final lastDate = _endDate != null ? _parseLocalDate(_endDate!) : DateTime(2101);
    final initialDate = _startDate != null ? _parseLocalDate(_startDate!) : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(lastDate) ? initialDate : lastDate,
      firstDate: DateTime(2000),
      lastDate: lastDate,
    );
    if (date != null) {
      setState(() {
        _startDate = date.toIso8601String();
        _startDateController.text = DateFormat('dd/MM/yyyy').format(date);
      });
      _notifyChanges();
    }
  }

  Future<void> _pickEndDate() async {
    final firstDate = _startDate != null ? _parseLocalDate(_startDate!) : DateTime(2000);
    final initialDate = _endDate != null ? _parseLocalDate(_endDate!) : firstDate;
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(firstDate) ? initialDate : firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );
    if (date != null) {
      setState(() {
        _endDate = date.toIso8601String();
        _endDateController.text = DateFormat('dd/MM/yyyy').format(date);
      });
      _notifyChanges();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.eventTypeIndex == 1) { // Concert
      return TextFormField(
        controller: _dateTimeController,
        readOnly: true,
        onTap: _pickDateTime,
        decoration: _fieldDecoration(context, t.events.datetime),
        validator: (val) => (val == null || val.isEmpty) ? t.errors.dateRequired : null,
      );
    } else { // Festival
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _startDateController,
              readOnly: true,
              onTap: _pickStartDate,
              decoration: _fieldDecoration(context, t.events.start),
              validator: (val) => (val == null || val.isEmpty) ? t.errors.requiredField : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: _endDateController,
              readOnly: true,
              enabled: _startDate != null,
              onTap: _startDate != null ? _pickEndDate : null,
              decoration: _fieldDecoration(context, t.events.end),
              validator: (val) =>
                (_startDate != null && (val == null || val.isEmpty))
                  ? t.errors.requiredField
                  : null,
            ),
          ),
        ],
      );
    }
  }
}
