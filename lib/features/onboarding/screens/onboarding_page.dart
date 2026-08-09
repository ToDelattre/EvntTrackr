import 'package:evnttrackr/main.dart';
import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/services/local_notification_service.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  late ConfettiController _confettiController;
  int _currentPage = 0;
  final int _totalPages = 5;

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

  late String _selectedLanguage;
  late String _selectedDateFormat;
  late ThemeMode _selectedThemeMode;
  late String _selectedThemeColor;
  late bool _notif1Week;
  late bool _notif1Day;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
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

  @override
  void dispose() {
    _pageController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishOnboarding(BuildContext context, String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_launch', false);
    
    if (context.mounted) {
      if (route == '/') {
        Navigator.pushReplacementNamed(context, '/');
      } else {
        Navigator.pushReplacementNamed(context, '/');
        Navigator.pushNamed(context, route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
            if (_currentPage > 0)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: const EdgeInsets.all(16),
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: _previousPage,
                  tooltip: t.onboarding.back,
                ),
              )
            else
              const SizedBox(height: 56), // Placeholder for back button height
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Prevent swipe to force use of buttons
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  if (index == _totalPages - 1) {
                    _confettiController.play();
                  } else {
                    _confettiController.stop();
                  }
                },
                children: [
                  _buildLanguagePage(theme),
                  _buildThemePage(theme),
                  _buildDateFormatPage(theme),
                  _buildNotificationsPage(theme),
                  _buildReadyPage(theme),
                ],
              ),
            ),
            _buildBottomControls(theme),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: drawStar,
          ),
        ),
      ],
    ),
  ),
);
  }

  Widget _buildLanguagePage(ThemeData theme) {
    return _buildPageWrapper(
      title: t.onboarding.welcomeTitle,
      subtitle: t.onboarding.welcomeSubtitle,
      icon: Icons.waving_hand_rounded,
      theme: theme,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              t.onboarding.languageTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ..._languageMap.entries.map((entry) {
            final isSelected = _selectedLanguage == entry.value;
            return _buildSelectionCard(
              title: entry.value,
              isSelected: isSelected,
              theme: theme,
              onTap: () {
                MainApp.of(context)?.setLocale(Locale(entry.key));
                setState(() => _selectedLanguage = entry.value);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildThemePage(ThemeData theme) {
    return _buildPageWrapper(
      title: t.onboarding.themeTitle,
      subtitle: t.onboarding.themeSubtitle,
      icon: Icons.color_lens_rounded,
      theme: theme,
      child: Column(
        children: [
          _buildSelectionCard(
            title: t.settings.light,
            icon: Icons.wb_sunny_rounded,
            isSelected: _selectedThemeMode == ThemeMode.light,
            theme: theme,
            onTap: () {
              MainApp.of(context)?.setThemeMode(ThemeMode.light);
              setState(() => _selectedThemeMode = ThemeMode.light);
            },
          ),
          _buildSelectionCard(
            title: t.settings.dark,
            icon: Icons.nightlight_round_rounded,
            isSelected: _selectedThemeMode == ThemeMode.dark,
            theme: theme,
            onTap: () {
              MainApp.of(context)?.setThemeMode(ThemeMode.dark);
              setState(() => _selectedThemeMode = ThemeMode.dark);
            },
          ),
          _buildSelectionCard(
            title: t.settings.system,
            icon: Icons.settings_suggest_rounded,
            isSelected: _selectedThemeMode == ThemeMode.system,
            theme: theme,
            onTap: () {
              MainApp.of(context)?.setThemeMode(ThemeMode.system);
              setState(() => _selectedThemeMode = ThemeMode.system);
            },
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Couleur de l'application",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
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

  Widget _buildDateFormatPage(ThemeData theme) {
    final localeCode = LocaleSettings.currentLocale.languageCode;

    String getFormattedExample(String format) {
      final formatter = DateFormat(
        format.replaceAll('D', 'd').replaceAll('Y', 'y'),
        localeCode,
      );
      return formatter.format(DateTime.now());
    }

    return _buildPageWrapper(
      title: t.onboarding.dateFormatTitle,
      subtitle: t.onboarding.dateFormatSubtitle,
      icon: Icons.calendar_today_rounded,
      theme: theme,
      child: Column(
        children: _dateFormats.map((format) {
          return _buildSelectionCard(
            title: getFormattedExample(format),
            isSelected: _selectedDateFormat == format,
            theme: theme,
            onTap: () {
              MainApp.of(context)?.setDateFormat(format);
              setState(() => _selectedDateFormat = format);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationsPage(ThemeData theme) {
    return _buildPageWrapper(
      title: t.onboarding.notificationsTitle,
      subtitle: t.onboarding.notificationsSubtitle,
      icon: Icons.notifications_active_rounded,
      theme: theme,
      child: Column(
        children: [
          _buildNotificationSwitch(
            title: t.settings.notif1WeekTitle,
            subtitle: t.settings.notif1WeekDesc,
            icon: Icons.calendar_month_rounded,
            value: _notif1Week,
            onChanged: (val) {
              if (val) LocalNotificationService().requestPermissions();
              MainApp.of(context)?.setNotif1Week(val);
              setState(() => _notif1Week = val);
            },
            theme: theme,
          ),
          const SizedBox(height: 12),
          _buildNotificationSwitch(
            title: t.settings.notif1DayTitle,
            subtitle: t.settings.notif1DayDesc,
            icon: Icons.timer_rounded,
            value: _notif1Day,
            onChanged: (val) {
              if (val) LocalNotificationService().requestPermissions();
              MainApp.of(context)?.setNotif1Day(val);
              setState(() => _notif1Day = val);
            },
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSwitch({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: value ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: value ? theme.colorScheme.primary : theme.iconTheme.color),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: value ? FontWeight.bold : FontWeight.normal,
            color: value ? theme.colorScheme.primary : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: value ? theme.colorScheme.primary.withValues(alpha: 0.8) : theme.hintColor,
            fontStyle: FontStyle.italic,
          ),
        ),
        value: value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildReadyPage(ThemeData theme) {
    return _buildPageWrapper(
      title: t.onboarding.readyTitle,
      subtitle: t.onboarding.readySubtitle,
      icon: Icons.rocket_launch_rounded,
      theme: theme,
      child: const SizedBox.shrink(), // No interactive cards here
    );
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  Widget _buildSelectionCard({
    required String title,
    String? subtitle,
    IconData? icon,
    required bool isSelected,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.1),
              width: 2,
            ),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.iconTheme.color),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.colorScheme.primary : null,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSelected ? theme.colorScheme.primary.withValues(alpha: 0.8) : theme.hintColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageWrapper({
    required String title,
    required String subtitle,
    required IconData icon,
    required ThemeData theme,
    required Widget child,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 32),
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: theme.textTheme.titleMedium?.copyWith(color: theme.hintColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          child,
        ],
      ),
    );
  }

  Widget _buildBottomControls(ThemeData theme) {
    if (_currentPage == _totalPages - 1) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: () => _finishOnboarding(context, '/login'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(t.auth.alreadyHaveAccount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: () => _finishOnboarding(context, '/signup'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(t.auth.dontHaveAccount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(_totalPages, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? theme.colorScheme.primary : theme.dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          FilledButton.icon(
            onPressed: _nextPage,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            label: Text(t.onboarding.next),
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }
}
