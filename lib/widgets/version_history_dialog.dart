import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:evnttrackr/theme/app_colors.dart';

class VersionHistoryDialog extends StatelessWidget {
  const VersionHistoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;

    final bool isFullWidth = screenWidth < 600 && orientation == Orientation.portrait;

    final List<VersionEntry> versionHistory = [
      VersionEntry(
        version: '2.3.0',
        date: '2026-08-08',
        changes: [
          ChangeEntry(ChangeType.add, 'Online event search with external data sources'),
          ChangeEntry(ChangeType.add, 'Local notifications for event reminders'),
          ChangeEntry(ChangeType.imp, 'UI improvements for achievements, profile, and stats pages'),
          ChangeEntry(ChangeType.imp, 'Material 3 Expressive design overhaul'),
          ChangeEntry(ChangeType.add, 'New onboarding flow and redesigned auth UI'),
          ChangeEntry(ChangeType.imp, 'Project architecture restructured for better performance'),
        ]
      ),
      VersionEntry(
        version : '2.2.1',
        date: '2026-03-23',
        changes: [
          ChangeEntry(ChangeType.fix, 'Fixed notification breaking interactions')
        ]
      ),
      VersionEntry(
        version : '2.2.0',
        date: '2026-03-23',
        changes: [
          ChangeEntry(ChangeType.add, 'Credentials can now be prefilled'),
          ChangeEntry(ChangeType.imp, 'Using modals instead of dialogs'),
          ChangeEntry(ChangeType.imp, 'New, more modern logo'),
          ChangeEntry(ChangeType.imp, 'Notifications overhaul'),
          ChangeEntry(ChangeType.imp, 'Stats page overhaul'),
          ChangeEntry(ChangeType.imp, 'Profile page overhaul'),
          ChangeEntry(ChangeType.imp, 'Settings page overhaul'),
          ChangeEntry(ChangeType.imp, 'About page overhaul'),
          ChangeEntry(ChangeType.imp, '"What\'s new" dialog can now be skipped'),
          ChangeEntry(ChangeType.imp, 'Improved translations'),
          ChangeEntry(ChangeType.imp, 'Saving indicator when creating/editing an event'),
          ChangeEntry(ChangeType.fix, 'Fixed Review sheet unexpectedly closing'),
          ChangeEntry(ChangeType.fix, 'Fixed commas being unusable for numbers'),
          ChangeEntry(ChangeType.fix, 'Fixed artists and location not being created in Title Case'),
        ]
      ),
      VersionEntry(
          version: '2.1.5',
          date: '2026-03-19',
          changes: [
            ChangeEntry(ChangeType.add, 'Added the possibility to rate an artist for an event'),
            ChangeEntry(ChangeType.add, 'Added automatic check for updates'),
            ChangeEntry(ChangeType.imp, 'Reduced tabs\' sizes in the home page'),
            ChangeEntry(ChangeType.imp, 'Improved the menu\'s visibility'),
            ChangeEntry(ChangeType.imp, 'Improved the version history dialog'),
            ChangeEntry(ChangeType.fix, 'Fixed incoherent behaviour of dates for festivals'),
            ChangeEntry(ChangeType.fix, 'Fixed tickets not being marked as bought after using the dedicated quick action button')
          ]
      ),
      VersionEntry(
          version: '2.1.4',
          date: '2026-03-10',
          changes: [
            ChangeEntry(ChangeType.add, 'Added location creation from event creation page'),
            ChangeEntry(ChangeType.imp, 'Improved password related interactions'),
            ChangeEntry(ChangeType.imp, 'Added an automatic refresh of the home tabs'),
          ]
      ),
      VersionEntry(
          version: '2.1.3',
          date: '2026-03-08',
          changes: [
            ChangeEntry(ChangeType.add, 'Added a quick access to app infos in settings'),
            ChangeEntry(ChangeType.imp, 'Improved the login page layout'),
            ChangeEntry(ChangeType.imp, 'Improved the menu layout'),
            ChangeEntry(ChangeType.fix, 'Handled android related navigation issues'),
            ChangeEntry(ChangeType.fix, 'Fixed menu not showing after first login'),
          ]
      ),
      VersionEntry(
          version: '2.1.0',
          date: '2026-03-04',
          changes: [
            ChangeEntry(ChangeType.add, 'Added an achievement page access from the profile page'),
            ChangeEntry(ChangeType.add, 'Added username edition from the profile page'),
            ChangeEntry(ChangeType.add, 'Added possibility to edit an event'),
            ChangeEntry(ChangeType.add, 'Added possibility to search for events by name or artist'),
            ChangeEntry(ChangeType.add, 'Added a compact display on the home page'),
            ChangeEntry(ChangeType.imp, 'Translations are now more accurate'),
            ChangeEntry(ChangeType.imp, 'Completely reworked the menu'),
            ChangeEntry(ChangeType.fix, 'Removed unintended Appbar color in PWA'),
            ChangeEntry(ChangeType.fix, 'Menu being reload on page change'),
            ChangeEntry(ChangeType.fix, 'Multiple critical bugs'),
            ChangeEntry(ChangeType.fix, 'Multiple display issues')
          ]
      ),
      VersionEntry(
          version: '2.0.1',
          date: '2026-02-28',
          changes: [
            ChangeEntry(ChangeType.fix, 'Fixed unable to login')
          ]
      ),
      VersionEntry(
          version: '2.0.0',
          date: '2026-02-28',
          changes: [
            ChangeEntry(ChangeType.add, 'Full migration to a native UI')
          ]
      ),
      VersionEntry(
          version: '1.0.0',
          date: '2025-10',
          changes: [
            ChangeEntry(ChangeType.add, 'Initial Vue3 release')
          ]
      ),
    ];

    return AlertDialog(
      insetPadding: isFullWidth
          ? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0)
          : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      title: Text(t.about.versionHistory),
      content: SizedBox(
        width: isFullWidth ? screenWidth : null,
        child: SingleChildScrollView(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodyMedium,
              children: _buildVersionHistory(versionHistory),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(t.common.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  List<InlineSpan> _buildVersionHistory(List<VersionEntry> history) {
    final List<InlineSpan> spans = [];

    for (var i = 0; i < history.length; i++) {
      final entry = history[i];

      spans.add(
        TextSpan(
          text: '${entry.version} (${entry.date})\n',
          style: const TextStyle(fontWeight: FontWeight.bold, height: 2.2),
        ),
      );

      for (final change in entry.changes) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: _buildTag(change.type),
            ),
          ),
        );
        spans.add(TextSpan(
          text: '${change.description}\n',
          style: const TextStyle(height: 1.6),
        ));
      }

      if (i < history.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return spans;
  }

  Widget _buildTag(ChangeType type) {
    Color color;
    String label;
    switch (type) {
      case ChangeType.add:
        color = AppColors.success;
        label = 'NEW';
        break;
      case ChangeType.imp:
        color = AppColors.secondary;
        label = 'IMP';
        break;
      case ChangeType.fix:
        color = AppColors.warning;
        label = 'FIX';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        border: Border.all(color: color.withAlpha(25), width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum ChangeType { add, imp, fix }

class ChangeEntry {
  final ChangeType type;
  final String description;

  const ChangeEntry(this.type, this.description);
}

class VersionEntry {
  final String version;
  final String date;
  final List<ChangeEntry> changes;

  const VersionEntry({
    required this.version,
    required this.date,
    required this.changes,
  });
}
