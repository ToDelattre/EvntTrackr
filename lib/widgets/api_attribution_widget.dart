import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiAttributionWidget extends StatelessWidget {
  const ApiAttributionWidget({super.key});

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      color: cs.surfaceContainerLowest,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Powered by',
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProviderLink(
                context,
                name: 'Ticketmaster',
                url: 'https://developer.ticketmaster.com/',
                icon: Icons.confirmation_number_rounded,
              ),
              const SizedBox(width: 12),
              _buildProviderLink(
                context,
                name: 'MusicBrainz',
                url: 'https://musicbrainz.org/',
                icon: Icons.music_note_rounded,
              ),
              const SizedBox(width: 12),
              _buildProviderLink(
                context,
                name: 'OpenStreetMap',
                url: 'https://www.openstreetmap.org/copyright',
                icon: Icons.map_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProviderLink(BuildContext context, {required String name, required String url, required IconData icon}) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            Icon(icon, size: 12, color: cs.primary),
            const SizedBox(width: 4),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                color: cs.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
