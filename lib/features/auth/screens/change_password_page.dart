import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/utils/validation_helper.dart';
import 'package:evnttrackr/widgets/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(
            password: _passwordController.text,
          ),
        );
        if (mounted) {
          NotificationHelper.showSuccess(
            context, 
            t.settings.passwordChangedSuccessfully
          );
          Navigator.of(context).pop();
        }
      } on AuthException catch (e) {
        if (mounted) {
          NotificationHelper.showError(context, e.message);
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.changePassword),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PasswordFormField(
                controller: _passwordController,
                labelText: t.settings.newPassword,
                validator: (value) => ValidationHelper.validatePassword(context, value),
              ),
              const SizedBox(height: 16),
              PasswordFormField(
                controller: _confirmPasswordController,
                labelText: t.settings.confirmNewPassword,
                validator: (value) => ValidationHelper.validateConfirmPassword(
                  context, 
                  value, 
                  _passwordController.text
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updatePassword,
                      child: Text(t.settings.changePassword),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
