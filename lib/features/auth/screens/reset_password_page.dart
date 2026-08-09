import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/utils/validation_helper.dart';
import 'package:evnttrackr/widgets/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(password: _passwordController.text),
        );

        await Supabase.instance.client.auth.signOut();

        if (mounted) {
          NotificationHelper.showSuccess(context, t.settings.passwordChangedSuccessfully);
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      } catch (error) {
        if (mounted) {
          NotificationHelper.showError(context, 'Error: ${error.toString()}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.changePassword),
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PasswordFormField(
                  controller: _passwordController,
                  labelText: t.settings.newPassword,
                  validator: (value) => ValidationHelper.validatePassword(context, value),
                ),
                const SizedBox(height: 16),
                PasswordFormField(
                  controller: _passwordConfirmationController,
                  labelText: t.settings.confirmNewPassword,
                  validator: (value) => ValidationHelper.validateConfirmPassword(
                    context, 
                    value, 
                    _passwordController.text
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: _resetPassword,
                  child: Text(t.common.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
