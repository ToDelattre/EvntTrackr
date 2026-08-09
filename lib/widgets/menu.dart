import 'dart:ui';
import 'package:evnttrackr/features/settings/screens/settings_page.dart';
import 'package:evnttrackr/features/events/screens/api_search_page.dart';
import 'package:evnttrackr/features/auth/screens/login_page.dart';
import 'package:evnttrackr/features/events/screens/create_event_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final String? currentRoute;
  final ValueChanged<String>? onRouteSelected;

  const AppBottomNavigationBar({
    super.key,
    this.currentRoute,
    this.onRouteSelected,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  bool _isExpanded = false;

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _handleNavigation(String routeName) {
    if (_isExpanded) _toggleMenu();
    
    final currentRoute = widget.currentRoute ?? ModalRoute.of(context)?.settings.name;
    if (currentRoute == routeName) return;

    if (widget.onRouteSelected != null) {
      widget.onRouteSelected!(routeName);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = widget.currentRoute ?? ModalRoute.of(context)?.settings.name;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    const double outerRadius = 32.0;
    const double innerRadius = 24.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding > 0 ? bottomPadding : 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Partie Menu (Navigation + Sous-menu)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sous-menu (Expansion) - Style M3 Surface
                  IgnorePointer(
                    ignoring: !_isExpanded,
                    child: AnimatedSlide(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      offset: _isExpanded ? Offset.zero : const Offset(0, 0.2),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: _isExpanded ? 1.0 : 0.0,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh.withAlpha(isDark ? 200 : 230),
                            borderRadius: BorderRadius.circular(innerRadius),
                            border: Border.all(
                              color: colorScheme.outlineVariant.withAlpha(isDark ? 60 : 120),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(isDark ? 100 : 40),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(innerRadius),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildExpandedItem(
                                    icon: Icons.settings_rounded,
                                    label: t.settings.settings,
                                    isActive: currentRoute == '/settings',
                                    onTap: () => _handleNavigation('/settings'),
                                    colorScheme: colorScheme,
                                  ),
                                  _buildExpandedItem(
                                    icon: Icons.info_outline_rounded,
                                    label: t.about.about,
                                    isActive: currentRoute == '/about',
                                    onTap: () => _handleNavigation('/about'),
                                    colorScheme: colorScheme,
                                  ),
                                  Divider(height: 1, indent: 16, endIndent: 16, color: colorScheme.outlineVariant),
                                  _buildExpandedItem(
                                    icon: Icons.logout_rounded,
                                    label: t.settings.logout,
                                    isDestructive: true,
                                    onTap: () async {
                                      _toggleMenu();
                                      await Supabase.instance.client.auth.signOut();
                                      if (context.mounted) {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (context) => const LoginPage()),
                                              (route) => false,
                                        );
                                      }
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer.withAlpha(isDark ? 200 : 230),
                      borderRadius: BorderRadius.circular(outerRadius),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withAlpha(isDark ? 60 : 120),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 80 : 30),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(outerRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildNavItem(
                              icon: _isExpanded ? Icons.close_rounded : Icons.menu_rounded,
                              onPressed: _toggleMenu,
                              colorScheme: colorScheme,
                              isActive: _isExpanded,
                              isDark: isDark,
                            ),
                            _buildNavItem(
                              icon: Icons.home_rounded,
                              isActive: currentRoute == '/',
                              onPressed: () => _handleNavigation('/'),
                              colorScheme: colorScheme,
                              isDark: isDark,
                            ),
                            _buildNavItem(
                              icon: Icons.person_rounded,
                              isActive: currentRoute == '/profile',
                              onPressed: () => _handleNavigation('/profile'),
                              colorScheme: colorScheme,
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
          
            SizedBox(
                height: 64,
                width: 64,
                child: FloatingActionButton(
                  onPressed: () {
                    if (_isExpanded) _toggleMenu();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ApiSearchPage(),
                        settings: const RouteSettings(name: '/api-search'),
                      ),
                    );
                  },
                  elevation: _isExpanded ? 0 : 4,
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add_rounded, size: 32),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    bool isActive = false,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
    required bool isDark,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: onPressed,
        highlightColor: Colors.transparent,
        splashColor: colorScheme.primary.withAlpha(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isActive ? 64 : 0,
                  height: 32,
                  decoration: ShapeDecoration(
                    color: isActive 
                        ? colorScheme.primary.withAlpha(40) 
                        : Colors.transparent,
                    shape: const StadiumBorder(),
                  ),
                ),
                Icon(
                  icon,
                  color: isActive 
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    bool isDestructive = false,
    bool isActive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isDestructive 
                    ? colorScheme.error 
                    : (isActive ? colorScheme.primary : colorScheme.onSurfaceVariant),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isDestructive 
                      ? colorScheme.error 
                      : (isActive ? colorScheme.primary : colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
