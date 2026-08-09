import 'package:flutter/material.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.privacy.privacyPolicy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(context, t.privacy.privacy_intro_title, t.privacy.privacy_intro_body),
            _buildSection(context, t.privacy.privacy_data_collected_title, t.privacy.privacy_data_collected_body),
            _buildSection(context, t.privacy.privacy_use_of_data_title, t.privacy.privacy_use_of_data_body),
            
            Text(
              t.privacy.privacy_user_rights_title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(t.privacy.privacy_user_rights_body, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            _buildBulletPoint(context, t.privacy.privacy_user_rights_list1),
            _buildBulletPoint(context, t.privacy.privacy_user_rights_list2),
            _buildBulletPoint(context, t.privacy.privacy_user_rights_list3),
            _buildBulletPoint(context, t.privacy.privacy_user_rights_list4),
            const SizedBox(height: 24),

            _buildSection(context, t.privacy.privacy_data_retention_title, t.privacy.privacy_data_retention_body),
            _buildSection(context, t.privacy.privacy_contact_title, t.privacy.privacy_contact_body),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: Theme.of(context).textTheme.bodyMedium),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
