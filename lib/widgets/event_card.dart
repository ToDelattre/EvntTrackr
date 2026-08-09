import 'package:evnttrackr/features/events/screens/event_details_page.dart';
import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class Artist {
  final String name;
  final bool isHeadliner;

  const Artist({required this.name, this.isHeadliner = false});
}

enum EventType { festival, concert }

class EventCard extends ConsumerWidget {
  final String id;
  final String title;
  final DateTime date;
  final DateTime? endDate;
  final String location;
  final List<Artist> artists;
  final bool showTicketButton;
  final EventType eventType;
  final bool isCompact;

  const EventCard({
    super.key,
    required this.id,
    required this.title,
    required this.date,
    this.endDate,
    required this.location,
    required this.artists,
    this.showTicketButton = false,
    required this.eventType,
    this.isCompact = false,
  });

  void _showTicketBottomSheet(BuildContext context, WidgetRef ref) {
    final priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final dbService = DatabaseService();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 8,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                t.events.addToUpcoming,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                t.events.addToUpcomingInfo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: t.events.ticketPriceOptional,
                  prefixIcon: const Icon(Icons.euro_symbol_rounded),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value != null && value.isNotEmpty && double.tryParse(value.replaceAll(',', '.')) == null) {
                    return t.errors.invalidPrice;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.common.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final price = double.tryParse(priceController.text.replaceAll(',', '.'));
                        try {
                          if (price != null && price > 0) {
                            await dbService.setEventPrice(int.parse(id), price);
                          }

                          await dbService.buyTicket(int.parse(id));

                          if (context.mounted) {
                            ref.read(eventsRefreshProvider.notifier).state++;
                            Navigator.of(context).pop();
                            NotificationHelper.showSuccess(context, t.events.eventAddedToUpcoming);
                          }
                        } on PostgrestException catch (error) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            NotificationHelper.showError(context, error.message);
                          }
                        }
                      }
                    },
                    child: Text(t.common.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfo(BuildContext context, Color cardColor) {
    final mainAppState = MainApp.of(context);
    final dateFormat = mainAppState?.dateFormat ?? 'DD/MM/YYYY';
    final locale = LocaleSettings.currentLocale.languageCode;
    final formatter =
        DateFormat(dateFormat.replaceAll('D', 'd').replaceAll('Y', 'y'), locale);

    final formattedDate = formatter.format(date);
    String dateText = formattedDate;

    if (endDate != null && DateUtils.dateOnly(date) != DateUtils.dateOnly(endDate!)) {
      final formattedendDate = formatter.format(endDate!);
      dateText = '$formattedDate - $formattedendDate';
    }

    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final eventStartDate = DateUtils.dateOnly(date);
    final eventendDate = endDate != null ? DateUtils.dateOnly(endDate!) : null;

    if (eventType == EventType.festival &&
        eventendDate != null &&
        (now.isAfter(eventStartDate) || DateUtils.isSameDay(now, eventStartDate)) &&
        (now.isBefore(eventendDate) || DateUtils.isSameDay(now, eventendDate))) {
      final festivalVisualEnd = eventendDate.add(const Duration(days: 1));
      final totalDuration = festivalVisualEnd.difference(eventStartDate);
      final progress = now.difference(eventStartDate);

      double value = 0.0;
      if (totalDuration.inMicroseconds > 0) {
        value = progress.inMicroseconds / totalDuration.inMicroseconds;
      }
      value = value.clamp(0.0, 1.0);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.event_repeat_rounded, size: isCompact ? 14 : 16, color: cardColor),
              SizedBox(width: isCompact ? 4 : 8),
              Text(t.events.event_ongoing, style: isCompact ? const TextStyle(fontSize: 12) : null),
              const Spacer(),
              Text(dateText, style: isCompact ? const TextStyle(fontSize: 12) : null),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              minHeight: isCompact ? 4 : 6,
              value: value,
              backgroundColor: cardColor.withAlpha(50),
              valueColor: AlwaysStoppedAnimation<Color>(cardColor),
            ),
          ),
        ],
      );
    }

    IconData statusIcon;
    String? statusText;

    if (eventStartDate.isAfter(today)) {
      final difference = eventStartDate.difference(today).inDays;
      statusIcon = Icons.hourglass_top_rounded;
      if (difference == 1) {
        statusText = t.common.tomorrow;
      } else {
        statusText = t.common.inDays(n: difference);
      }
    } else if (DateUtils.isSameDay(eventStartDate, today)) {
      statusIcon = Icons.event_available_rounded;
      statusText = t.common.today;
    } else {
      statusIcon = Icons.calendar_today_rounded;
      statusText = null;
    }

    final children = <Widget>[
      Icon(statusIcon, size: isCompact ? 14 : 16, color: cardColor),
      SizedBox(width: isCompact ? 4 : 8),
    ];

    if (statusText != null) {
      children.addAll([
        Text(statusText, style: isCompact ? const TextStyle(fontSize: 12) : null),
        const Spacer(),
        Text(dateText, style: isCompact ? const TextStyle(fontSize: 12) : null),
      ]);
    } else {
      children.add(Text(dateText, style: isCompact ? const TextStyle(fontSize: 12) : null));
    }

    return Row(children: children);
  }

  Widget _buildArtistSection(
      BuildContext context, Color cardColor, List<Artist> sortedArtists) {
    if (isCompact) return const SizedBox.shrink();
    
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: [
        ...sortedArtists.take(10).map((artist) {
          return Chip(
            label: Text(
              artist.name,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
              side: BorderSide(
                color:
                    artist.isHeadliner ? cardColor : Colors.grey.shade400,
              ),
            ),
          );
        }),
        if (artists.length > 10)
          Chip(
            label: const Text('...',
                style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            shape: StadiumBorder(
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color cardColor = Theme.of(context).colorScheme.primary;

    final sortedArtists = artists.toList()
      ..sort((a, b) => (b.isHeadliner ? 1 : 0) - (a.isHeadliner ? 1 : 0));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(eventId: int.parse(id)),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 16, 
          vertical: isCompact ? 6 : 10
        ),
        elevation: isCompact ? 2 : 6,
        shadowColor: cardColor.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).cardTheme.color ?? Colors.white,
                Theme.of(context).cardTheme.color?.withValues(alpha: 0.9) ?? Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border(
              left: BorderSide(color: cardColor, width: 4),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(isCompact ? 12.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: (isCompact 
                          ? Theme.of(context).textTheme.titleMedium 
                          : Theme.of(context).textTheme.headlineSmall)?.copyWith(
                              color: cardColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (eventType == EventType.festival)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: cardColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t.events.festival,
                          style: TextStyle(
                            color: cardColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: isCompact ? 6 : 12),
                _buildDateInfo(context, cardColor),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: isCompact ? 14 : 18, color: cardColor.withValues(alpha: 0.8)),
                    SizedBox(width: isCompact ? 4 : 8),
                    Expanded(
                      child: Text(
                        location,
                        style: (isCompact ? Theme.of(context).textTheme.bodySmall : Theme.of(context).textTheme.bodyMedium)?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (!isCompact) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1, thickness: 1),
                  const SizedBox(height: 16),
                  _buildArtistSection(context, cardColor, sortedArtists),
                ],
                if (showTicketButton && !isCompact)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.confirmation_number_rounded, size: 18),
                        label: Text(t.common.add),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cardColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _showTicketBottomSheet(context, ref),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
