import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class WhatsNewDialog extends StatefulWidget {
  const WhatsNewDialog({super.key});

  @override
  State<WhatsNewDialog> createState() => _WhatsNewDialogState();
}

class _WhatsNewDialogState extends State<WhatsNewDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<WhatsNewItem> _items = [
    WhatsNewItem(
      title: t.auth.welcome,
      description: t.auth.welcomedescription,
      imagePath: null,
      icon: Icons.celebration_rounded,
    ),
    WhatsNewItem(
      title: t.auth.new3,
      description: t.auth.new3description,
      imagePath: null,
      icon: Icons.format_paint_rounded,
    ),
    WhatsNewItem(
      title: t.auth.new1,
      description: t.auth.new1description,
      imagePath: null,
      icon: Icons.rate_review_rounded,
    ),
    WhatsNewItem(
      title: t.auth.new2,
      description: t.auth.new2description,
      imagePath: null,
      icon: Icons.security_update_rounded,
    ),
    WhatsNewItem(
      title: t.auth.moretocome,
      description: t.auth.alwaysimproving,
      imagePath: null,
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 560),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Opacity(
                  opacity: 0,
                  child: IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: null,
                  ),
                ),
                Text(
                  t.auth.whatsnew,
                  style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) =>
                    setState(() => _currentPage = page),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.imagePath != null)
                        Expanded(child: Image.asset(item.imagePath!))
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(item.icon, size: 64, color: theme.colorScheme.onPrimaryContainer),
                        ),
                      const SizedBox(height: 24),
                      Text(
                        item.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) {
                  final isActive = _currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  if (_currentPage < _items.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  _currentPage < _items.length - 1
                      ? t.common.next
                      : t.auth.letsgo,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhatsNewItem {
  final String title;
  final String description;
  final String? imagePath;
  final IconData icon;

  WhatsNewItem({
    required this.title,
    required this.description,
    this.imagePath,
    required this.icon,
  });
}
