import 'package:evnttrackr/features/auth/screens/change_password_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:evnttrackr/providers/database_provider.dart';
import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/services/database_service.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/services/local_notification_service.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  DatabaseService get _dbService => ref.read(databaseServiceProvider);
  late String _selectedLanguage;
  late String _selectedDateFormat;
  late ThemeMode _selectedThemeMode;
  late String _selectedThemeColor;
  late bool _notif1Week;
  late bool _notif1Day;
  String _appVersion = '';

  static const Map<String, String> _languageMap = {
    'en': 'English',
    'de': 'Deutsch',
    'fr': 'Français',
    'nl': 'Nederlands',
  };

  static const List<String> _dateFormats = [
    'DD/MM/YYYY',
    'DD/MMM/YYYY',
    'DD/MMMM/YYYY',
    'MM/DD/YYYY',
    'MMM/DD/YYYY',
    'MMMM/DD/YYYY'
  ];

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = "${packageInfo.version}+${packageInfo.buildNumber}";
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mainApp = MainApp.of(context);
    if (mainApp != null) {
      _selectedThemeMode = mainApp.themeMode;
      _selectedDateFormat = mainApp.dateFormat;
      _selectedThemeColor = mainApp.themeColor;
      _notif1Week = mainApp.notif1Week;
      _notif1Day = mainApp.notif1Day;
      final locale = LocaleSettings.currentLocale.flutterLocale;
      _selectedLanguage = _languageMap[locale.languageCode] ?? 'Français';
    }
  }

  Future<void> _manualUpdateCheck() async {
    await Upgrader.clearSavedSettings();
    if (!mounted) return;
    NotificationHelper.showInfo(context, t.update.appUpToDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
        children: [
          _buildCategoryHeader(t.settings.preferences, theme),
          _buildPreferencesCard(theme),
          const SizedBox(height: 24),
          _buildCategoryHeader(t.settings.account, theme),
          _buildAccountCard(theme),
          const SizedBox(height: 24),
          _buildCategoryHeader(t.settings.app, theme),
          _buildAppCard(theme),
          const SizedBox(height: 48),
          _buildFooter(theme),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildPreferencesCard(ThemeData theme) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildLanguageTile(theme),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildDateFormatTile(theme),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildThemeTile(theme),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildThemeColorTile(theme),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildNotificationsTile1Week(theme),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          _buildNotificationsTile1Day(theme),
        ],
      ),
    );
  }

  Widget _buildNotificationsTile1Week(ThemeData theme) {
    return SwitchListTile(
      secondary: Icon(Icons.calendar_month_rounded, color: theme.colorScheme.primary),
      title: Text(t.settings.notif1WeekTitle),
      subtitle: Text(t.settings.notif1WeekDesc),
      value: _notif1Week,
      onChanged: (bool value) async {
        if (value) {
          await LocalNotificationService().requestPermissions();
        }
        MainApp.of(context)?.setNotif1Week(value);
        setState(() {
          _notif1Week = value;
        });
        _syncNotifications();
      },
    );
  }

  Widget _buildNotificationsTile1Day(ThemeData theme) {
    return SwitchListTile(
      secondary: Icon(Icons.timer_rounded, color: theme.colorScheme.primary),
      title: Text(t.settings.notif1DayTitle),
      subtitle: Text(t.settings.notif1DayDesc),
      value: _notif1Day,
      onChanged: (bool value) async {
        if (value) {
          await LocalNotificationService().requestPermissions();
        }
        MainApp.of(context)?.setNotif1Day(value);
        setState(() {
          _notif1Day = value;
        });
        _syncNotifications();
      },
    );
  }

  Future<void> _syncNotifications() async {
    final response = await _dbService.getUpcomingEvents(limit: 50, offset: 0);
    await LocalNotificationService().syncNotifications(
      response,
      enable1Week: _notif1Week,
      enable1Day: _notif1Day,
    );
  }


  Widget _buildLanguageTile(ThemeData theme) {
    return ListTile(
      leading: Icon(Icons.language_rounded, color: theme.colorScheme.primary),
      title: Text(t.settings.language),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              final languageCode = _languageMap.entries
                  .firstWhere((entry) => entry.value == newValue)
                  .key;
              MainApp.of(context)?.setLocale(Locale(languageCode));
              setState(() {
                _selectedLanguage = newValue;
              });
            }
          },
          items: _languageMap.values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateFormatTile(ThemeData theme) {
    final localeCode = LocaleSettings.currentLocale.languageCode;
    String getFormattedExample(String format) {
      final formatter = DateFormat(
        format.replaceAll('D', 'd').replaceAll('Y', 'y'),
        localeCode,
      );
      return formatter.format(DateTime.now());
    }

    return ListTile(
      leading: Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary),
      title: Text(t.settings.dateFormat),
      subtitle: Text("ex: ${getFormattedExample(_selectedDateFormat)}"),
      trailing: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDateFormat,
          icon: const Icon(Icons.arrow_drop_down_rounded),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (newValue) {
            if (newValue != null) {
              MainApp.of(context)?.setDateFormat(newValue);
              setState(() {
                _selectedDateFormat = newValue;
              });
            }
          },
          items: _dateFormats.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildThemeTile(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.brightness_medium_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 16),
              Text(t.settings.displayMode, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              segments: <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text(t.settings.light),
                  icon: const Icon(Icons.wb_sunny_rounded),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text(t.settings.dark),
                  icon: const Icon(Icons.nightlight_round_rounded),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text(t.settings.system),
                  icon: const Icon(Icons.settings_suggest_rounded),
                ),
              ],
              selected: <ThemeMode>{_selectedThemeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                final newMode = newSelection.first;
                MainApp.of(context)?.setThemeMode(newMode);
                setState(() {
                  _selectedThemeMode = newMode;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeColorTile(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette_rounded, color: theme.colorScheme.primary),
              const SizedBox(width: 16),
              Text("Couleur de l'application", style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildColorCircle('system', Colors.grey, Icons.auto_awesome_rounded),
                const SizedBox(width: 12),
                _buildColorCircle('teal', AppColors.seedColors['teal']!),
                const SizedBox(width: 12),
                _buildColorCircle('indigo', AppColors.seedColors['indigo']!),
                const SizedBox(width: 12),
                _buildColorCircle('amber', AppColors.seedColors['amber']!),
                const SizedBox(width: 12),
                _buildColorCircle('rose', AppColors.seedColors['rose']!),
                const SizedBox(width: 12),
                _buildColorCircle('emerald', AppColors.seedColors['emerald']!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(String colorKey, Color color, [IconData? icon]) {
    final isSelected = _selectedThemeColor == colorKey;
    return GestureDetector(
      onTap: () {
        MainApp.of(context)?.setThemeColor(colorKey);
        setState(() {
          _selectedThemeColor = colorKey;
        });
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Theme.of(context).colorScheme.onSurface, width: 3) : null,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: isSelected || icon != null
            ? Icon(
                icon ?? Icons.check_rounded,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  Widget _buildAccountCard(ThemeData theme) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.lock_outline_rounded, color: theme.colorScheme.primary),
            title: Text(t.settings.changePassword),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
              );
            },
          ),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          ListTile(
            leading: const Icon(Icons.refresh_rounded, color: Color(0xFFf97316)),
            title: Text(
              t.settings.resetAccount,
              style: const TextStyle(color: Color(0xFFf97316), fontWeight: FontWeight.bold),
            ),
            subtitle: Text(t.settings.resetAccountWarning),
            onTap: () => _showConfirmationBottomSheet(
              context,
              title: t.settings.resetAccount,
              message: t.settings.resetAccountWarning,
              confirmText: t.settings.resetAccount,
              isDestructive: false,
              onConfirm: () => _handleAccountAction('account_reset'),
            ),
          ),
          Divider(height: 1, indent: 56, color: theme.dividerColor.withValues(alpha: 0.1)),
          ListTile(
            leading: Icon(Icons.delete_forever_rounded, color: theme.colorScheme.error),
            title: Text(
              t.settings.deleteAccount,
              style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(t.settings.deleteAccountWarning),
            onTap: () => _showConfirmationBottomSheet(
              context,
              title: t.settings.deleteAccount,
              message: t.settings.deleteAccountWarning,
              confirmText: t.common.delete,
              isDestructive: true,
              onConfirm: () => _handleAccountAction('account_delete'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard(ThemeData theme) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: ListTile(
        leading: Icon(Icons.system_update_rounded, color: theme.colorScheme.primary),
        title: Text(t.update.checkUpdate),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: _manualUpdateCheck,
      ),
    );
  }

  Widget _buildFooter(ThemeData theme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/privacy-policy'),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  t.privacy.privacyPolicy,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text("•", style: TextStyle(color: theme.dividerColor)),
            InkWell(
              onTap: () => launchUrl(Uri.parse('mailto:evnt.trackr@gmail.com?subject=%5BFeedback%5D')),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "Feedback",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Opacity(
          opacity: 0.5,
          child: Text(
            "v$_appVersion",
            style: theme.textTheme.bodySmall?.copyWith(letterSpacing: 1.1),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAccountAction(String rpcName) async {
    try {
      await _dbService.callUserRpc(rpcName);
      await Supabase.instance.client.auth.signOut();
    } on PostgrestException catch (error) {
      if (mounted) {
        NotificationHelper.showError(context, error.message);
      }
    } catch (e) {
      if (mounted) {
        NotificationHelper.showError(context, e.toString());
      }
    }
  }

  void _showConfirmationBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required bool isDestructive,
    required Future<void> Function() onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(t.common.cancel),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await onConfirm();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: isDestructive ? Theme.of(context).colorScheme.error : const Color(0xFFf97316),
                      foregroundColor: isDestructive ? Theme.of(context).colorScheme.onError : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(confirmText, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
