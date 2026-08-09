import 'dart:async';

import 'package:evnttrackr/features/settings/screens/about_page.dart';
import 'package:evnttrackr/features/auth/screens/login_page.dart';
import 'package:evnttrackr/features/auth/screens/signup_page.dart';
import 'package:evnttrackr/features/events/screens/main_screen.dart';
import 'package:evnttrackr/features/settings/screens/privacy_policy_page.dart';
import 'package:evnttrackr/features/profile/screens/profile_page.dart';
import 'package:evnttrackr/features/auth/screens/reset_password_page.dart';
import 'package:evnttrackr/features/settings/screens/settings_page.dart';
import 'package:evnttrackr/features/onboarding/screens/onboarding_page.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/widgets/whats_new_dialog.dart';
import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:evnttrackr/services/local_notification_service.dart';
import 'package:evnttrackr/services/database_service.dart';

/// Point d'entrée de l'application. 
/// Initialise les services essentiels comme Supabase et configure l'UI globale.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Upgrader.clearSavedSettings();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  await LocalNotificationService().init();

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: MainApp(isFirstLaunch: isFirstLaunch),
      ),
    ),
  );
}

/// Widget racine gérant le thème, la localisation et la navigation.
class MainApp extends StatefulWidget {
  final bool isFirstLaunch;

  const MainApp({
    super.key,
    this.isFirstLaunch = false,
  });

  @override
  State<MainApp> createState() => MainAppState();

  static MainAppState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_MainAppScope>()?.state;
}

class _MainAppScope extends InheritedWidget {
  final MainAppState state;

  const _MainAppScope({
    required this.state,
    required super.child,
  });

  @override
  bool updateShouldNotify(_MainAppScope oldWidget) => true;
}

class MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  String _dateFormat = 'DD/MM/YYYY';
  String get dateFormat => _dateFormat;

  String _themeColor = 'system';
  String get themeColor => _themeColor;

  bool _notif1Week = false;
  bool get notif1Week => _notif1Week;

  bool _notif1Day = false;
  bool get notif1Day => _notif1Day;

  late final StreamSubscription<AuthState> _authStateSubscription;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
    _loadDateFormat();
    _loadLocale();
    _loadThemeColor();
    _loadNotificationsEnabled();

    // Gestion centralisée de l'authentification
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        Future.delayed(Duration.zero, () {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil('/reset-password', (route) => false);
        });
      }
    });
  }

  Future<void> checkVersion() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) return;

    final prefs = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();

    final String currentVersion = packageInfo.version;
    final String? lastVersion = prefs.getString('last_version');

    if (lastVersion != currentVersion) {
      final navContext = _navigatorKey.currentContext;

      if (navContext != null && navContext.mounted) {
        showDialog(
          context: navContext,
          barrierDismissible: false,
          builder: (context) => const WhatsNewDialog(),
        );

        // On n'enregistre la version QUE si le dialogue a pu être affiché
        await prefs.setString('last_version', currentVersion);
      }
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == 'ThemeMode.$themeModeString',
        orElse: () => ThemeMode.system,
      );
    });
  }

  void _loadDateFormat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dateFormat = prefs.getString('dateFormat') ?? 'DD/MM/YYYY';
    });
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');
    
    if (languageCode != null) {
      LocaleSettings.setLocaleRaw(languageCode);
    } else {
      LocaleSettings.useDeviceLocale();
    }
  }

  void setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
    setState(() {
      _themeMode = mode;
    });
  }

  void _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeColor = prefs.getString('themeColor') ?? 'system';
    });
  }

  void setThemeColor(String colorKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeColor', colorKey);
    setState(() {
      _themeColor = colorKey;
    });
  }

  void setDateFormat(String format) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dateFormat', format);
    setState(() {
      _dateFormat = format;
    });
  }

  void _loadNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final legacy = prefs.getBool('notificationsEnabled');
    final enabled1W = prefs.getBool('notif1Week') ?? (legacy ?? false);
    final enabled1D = prefs.getBool('notif1Day') ?? (legacy ?? false);
    
    setState(() {
      _notif1Week = enabled1W;
      _notif1Day = enabled1D;
    });

    if ((enabled1W || enabled1D) && Supabase.instance.client.auth.currentSession != null) {
      final dbService = DatabaseService();
      try {
        final response = await dbService.getUpcomingEvents(limit: 50, offset: 0);
        await LocalNotificationService().syncNotifications(
          response, 
          enable1Week: enabled1W, 
          enable1Day: enabled1D,
        );
      } catch (e) {
        debugPrint('Erreur lors de la synchro des notifications: $e');
      }
    }
  }

  void setNotif1Week(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif1Week', enabled);
    setState(() {
      _notif1Week = enabled;
    });
  }

  void setNotif1Day(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif1Day', enabled);
    setState(() {
      _notif1Day = enabled;
    });
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    LocaleSettings.setLocaleRaw(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return _MainAppScope(
      state: this,
      child: UpgradeAlert(
        upgrader: Upgrader(
          debugLogging: true,
          durationUntilAlertAgain: const Duration(days: 1),
        ),
        child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightScheme;
            ColorScheme darkScheme;

            final useCustomColor = _themeColor != 'system';
            final seedColor = AppColors.seedColors[_themeColor] ?? AppColors.primary;

            if (!useCustomColor && lightDynamic != null && darkDynamic != null) {
              lightScheme = ColorScheme.fromSeed(
                seedColor: lightDynamic.primary,
                brightness: Brightness.light,
              );
              darkScheme = ColorScheme.fromSeed(
                seedColor: darkDynamic.primary,
                brightness: Brightness.dark,
              );
            } else {
              lightScheme = ColorScheme.fromSeed(
                seedColor: seedColor,
                brightness: Brightness.light,
              );
              darkScheme = ColorScheme.fromSeed(
                seedColor: seedColor,
                brightness: Brightness.dark,
              );
            }

            return MaterialApp(
              navigatorKey: _navigatorKey,
              scaffoldMessengerKey: NotificationHelper.messengerKey,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: lightScheme,
                scaffoldBackgroundColor: lightScheme.surface,
                textTheme: GoogleFonts.outfitTextTheme(ThemeData(colorScheme: lightScheme).textTheme).copyWith(
                  displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 57, letterSpacing: -0.25),
                  headlineLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 32),
                  titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 22),
                  labelLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: lightScheme.surface,
                  foregroundColor: lightScheme.onSurface,
                  elevation: 0,
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                ),
                cardTheme: CardThemeData(
                  color: lightScheme.surfaceContainer,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  clipBehavior: Clip.antiAlias,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                filledButtonTheme: FilledButtonThemeData(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: lightScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: lightScheme.primary, width: 2),
                  ),
                ),
                navigationBarTheme: NavigationBarThemeData(
                  elevation: 0,
                  backgroundColor: lightScheme.surfaceContainer,
                  indicatorColor: lightScheme.secondaryContainer,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                ),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: darkScheme,
                scaffoldBackgroundColor: darkScheme.surface,
                textTheme: GoogleFonts.outfitTextTheme(ThemeData(colorScheme: darkScheme).textTheme).copyWith(
                  displayLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 57, letterSpacing: -0.25),
                  headlineLarge: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 32),
                  titleLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 22),
                  labelLarge: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                appBarTheme: AppBarTheme(
                  backgroundColor: darkScheme.surface,
                  foregroundColor: darkScheme.onSurface,
                  elevation: 0,
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                ),
                cardTheme: CardThemeData(
                  color: darkScheme.surfaceContainer,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  clipBehavior: Clip.antiAlias,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                filledButtonTheme: FilledButtonThemeData(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: darkScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: darkScheme.primary, width: 2),
                  ),
                ),
                navigationBarTheme: NavigationBarThemeData(
                  elevation: 0,
                  backgroundColor: darkScheme.surfaceContainer,
                  indicatorColor: darkScheme.secondaryContainer,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                ),
              ),
              themeMode: _themeMode,
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              initialRoute: widget.isFirstLaunch
                  ? '/onboarding'
                  : (Supabase.instance.client.auth.currentSession == null ? '/login' : '/'),
              onGenerateRoute: (settings) {
                final session = Supabase.instance.client.auth.currentSession;
                final publicRoutes = ['/login', '/signup', '/reset-password', '/privacy-policy', '/onboarding'];
            
                if (session == null && !publicRoutes.contains(settings.name)) {
                  return MaterialPageRoute(builder: (context) => const LoginPage(), settings: settings);
                }
            
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(builder: (context) => const MainScreen(), settings: settings);
                  case '/onboarding':
                    return MaterialPageRoute(builder: (context) => const OnboardingPage(), settings: settings);
                  case '/login':
                    return MaterialPageRoute(builder: (context) => const LoginPage(), settings: settings);
                  case '/signup':
                    return MaterialPageRoute(builder: (context) => const SignupPage(), settings: settings);
                  case '/profile':
                    return MaterialPageRoute(builder: (context) => const ProfilePage(), settings: settings);
                  case '/settings':
                    return MaterialPageRoute(builder: (context) => const SettingsPage(), settings: settings);
                  case '/about':
                    return MaterialPageRoute(builder: (context) => const AboutPage(), settings: settings);
                  case '/reset-password':
                    return MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(), settings: settings);
                  case '/privacy-policy':
                    return MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage(), settings: settings);
                  default:
                    return MaterialPageRoute(builder: (context) => const LoginPage(), settings: settings);
                }
              },
            );
          }
        ),
      ),
    );
  }
}
