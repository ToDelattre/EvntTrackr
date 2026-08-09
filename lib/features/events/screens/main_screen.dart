import 'package:evnttrackr/features/settings/screens/about_page.dart';
import 'package:evnttrackr/features/events/screens/home_page.dart';
import 'package:evnttrackr/main.dart';
import 'package:evnttrackr/features/profile/screens/profile_page.dart';
import 'package:evnttrackr/features/settings/screens/settings_page.dart';
import 'package:evnttrackr/widgets/menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _currentRoute = '/';

  final Map<String, Widget> _pages = {
    '/': const HomePage(),
    '/profile': const ProfilePage(),
    '/settings': const SettingsPage(),
    '/about': const AboutPage(),
  };

  @override
  void initState() {
    super.initState();
    // On vérifie la version au chargement de l'écran principal (après login)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MainApp.of(context)?.checkVersion();
    });
  }

  void _onRouteSelected(String route) {
    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _pages.keys.toList().indexOf(_currentRoute),
            children: _pages.values.toList(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AppBottomNavigationBar(
              currentRoute: _currentRoute,
              onRouteSelected: _onRouteSelected,
            ),
          ),
        ],
      ),
    );
  }
}
