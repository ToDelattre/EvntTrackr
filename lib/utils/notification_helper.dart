import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum NotificationType { success, error, warning, info }

class NotificationHelper {
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  static OverlayEntry? _currentOverlay;

  static void show(
      BuildContext context, {
        required String message,
        NotificationType type = NotificationType.info,
      }) {
    final color = _getColor(context, type);
    final icon = _getIcon(type);

    _showOverlayNotification(context, message, color, icon);
  }

  static void _showOverlayNotification(
      BuildContext context,
      String message,
      Color color,
      IconData icon,
      ) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _NotificationWidget(
        message: message,
        color: color,
        icon: icon,
        onDismiss: () {
          overlayEntry.remove();
          if (_currentOverlay == overlayEntry) _currentOverlay = null;
        },
      ),
    );

    _currentOverlay = overlayEntry;
    overlayState.insert(overlayEntry);
  }

  // Les méthodes showSuccess, showError, etc. restent identiques
  static void showSuccess(BuildContext context, String message) => show(context, message: message, type: NotificationType.success);
  static void showError(BuildContext context, String message) => show(context, message: message, type: NotificationType.error);
  static void showWarning(BuildContext context, String message) => show(context, message: message, type: NotificationType.warning);
  static void showInfo(BuildContext context, String message) => show(context, message: message, type: NotificationType.info);

  static Color _getColor(BuildContext context, NotificationType type) {
    switch (type) {
      case NotificationType.success: return AppColors.success;
      case NotificationType.error: return AppColors.error;
      case NotificationType.warning: return AppColors.warning;
      case NotificationType.info: return Theme.of(context).colorScheme.primary;
    }
  }

  static IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success: return Icons.check_circle_rounded;
      case NotificationType.error: return Icons.error_rounded;
      case NotificationType.warning: return Icons.warning_rounded;
      case NotificationType.info: return Icons.info_rounded;
    }
  }
}

class _NotificationWidget extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismiss;

  const _NotificationWidget({
    required this.message,
    required this.color,
    required this.icon,
    required this.onDismiss,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Mélange le fond de l'application avec la couleur de la notification
    final bgColor = Color.lerp(theme.colorScheme.surface, widget.color, isDark ? 0.25 : 0.15) ?? theme.colorScheme.surface;
    final borderColor = widget.color.withValues(alpha: isDark ? 0.4 : 0.3);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: borderColor, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withValues(alpha: isDark ? 0.2 : 0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: widget.color.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(widget.icon, color: widget.color, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}