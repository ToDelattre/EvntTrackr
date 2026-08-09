import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/widgets/version_history_dialog.dart';
import 'package:evnttrackr/widgets/whats_new_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:evnttrackr/i18n/strings.g.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.about.about),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 120.0),
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildCategoryHeader(t.about.about_support_title, theme),
          _buildSupportCard(context),
          const SizedBox(height: 16),
          _buildDonationCard(context),
          const SizedBox(height: 24),
          _buildCategoryHeader(t.about.about, theme),
          _buildInfoCards(context),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 16.0, bottom: 8.0),
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

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 16),
        SvgPicture.asset(
          'assets/images/evnt-trackr.svg',
          height: 100,
        ),
        const SizedBox(height: 16),
        Text(
          'EvntTrackr',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        if (_version.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            '${t.about.version} $_version',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
          ),
        ],
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            t.about.about_intro1,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            t.about.about_intro2,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSupportCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              t.about.about_feedback_text,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSocialButton(
                    icon: Icons.email_rounded,
                    label: "Email",
                    tooltip: t.about.about_email_tooltip,
                    onPressed: () {
                      final String subject = Uri.encodeComponent('[Feedback] EvntTrackr');
                      final String body = Uri.encodeComponent(
                          '\n\n'
                              '---\n'
                              'App Version: $_version\n'
                              'Platform: ${Theme.of(context).platform.name}\n'
                              'Locale: ${Localizations.localeOf(context)}'
                      );

                      launchUrl(Uri.parse('mailto:evnt.trackr@gmail.com?subject=$subject&body=$body'));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSocialButton(
                    isSvg: true,
                    svgAsset: 'assets/images/instagram.svg',
                    label: "Instagram",
                    color: AppColors.instagram,
                    tooltip: t.about.about_instagram_tooltip,
                    onPressed: () => launchUrl(Uri.parse('https://www.instagram.com/evnt.trackr?igsh=ZjU5ZzN5MmNyOHFj')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    String? svgAsset,
    bool isSvg = false,
    Color? color,
    String? label,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.colorScheme.primary;

    return Tooltip(
      message: tooltip,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: buttonColor.withValues(alpha: 0.1),
          foregroundColor: buttonColor,
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSvg
                ? SvgPicture.asset(
                    svgAsset!,
                    height: 36,
                    width: 36,
                    colorFilter: ColorFilter.mode(buttonColor, BlendMode.srcIn),
                  )
                : Icon(icon, color: buttonColor, size: 36),
            if (label != null) ...[
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: buttonColor,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDonationCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              t.about.about_donation_text,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 54,
                  child: KofiButton(
                    kofiName: 'ToDelattre',
                    text: t.about.about_kofi_button,
                    kofiColor: KofiColor.Red,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 54,
                  child: PayPalButton(
                    paypalButtonId: 'CXTVLGWCUDTQW',
                    donationText: t.about.about_paypal_button,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF003087),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Column(
      children: [
        _buildListTileCard(
          icon: Icons.history_rounded,
          title: t.about.versionHistory,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const VersionHistoryDialog();
              },
            );
          },
        ),
        const SizedBox(height: 8),
        _buildListTileCard(
          icon: Icons.privacy_tip_rounded,
          title: t.privacy.privacyPolicy,
          onTap: () {
            Navigator.pushNamed(context, '/privacy-policy');
          },
        ),
        const SizedBox(height: 8),
        _buildListTileCard(
          icon: Icons.info_rounded,
          title: t.about.about_see_whatsnew,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const WhatsNewDialog(),
            );
          }
        ),
        const SizedBox(height: 8),
        _buildListTileCard(
          icon: Icons.star_rounded,
          title: t.about.rate_us,
          onTap: () {
            launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.evnttrackr'));
          },
        ),
      ],
    );
  }

  Widget _buildListTileCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_rounded, size: 20),
        onTap: onTap,
      ),
    );
  }
}
