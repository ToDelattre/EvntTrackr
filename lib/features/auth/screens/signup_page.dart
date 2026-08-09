import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/utils/validation_helper.dart';
import 'package:evnttrackr/widgets/password_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _privacyPolicyAccepted = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_privacyPolicyAccepted) {
      NotificationHelper.showWarning(context, t.errors.pleaseAcceptPrivacyPolicy);
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      if (mounted) {
        NotificationHelper.showSuccess(context, t.auth.confirmationEmailSent);
        Navigator.pop(context);
      }
    } on AuthException catch (error) {
      if (mounted) {
        NotificationHelper.showError(context, error.message);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.auth.signUp),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Center(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: t.auth.username,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.errors.pleaseEnterAUsername;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: t.auth.email,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return t.auth.pleaseEnterYourEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: _passwordController,
                    labelText: t.auth.password,
                    validator: (value) => ValidationHelper.validatePassword(context, value),
                  ),
                  const SizedBox(height: 16),
                  PasswordFormField(
                    controller: _confirmPasswordController,
                    labelText: t.auth.confirmPassword,
                    validator: (value) => ValidationHelper.validateConfirmPassword(
                      context, 
                      value, 
                      _passwordController.text
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _privacyPolicyAccepted,
                        onChanged: (value) {
                          setState(() {
                            _privacyPolicyAccepted = value ?? false;
                          });
                        },
                        activeColor: primaryColor,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(text: '${t.auth.acceptPrivacyPolicy.split(
                                  t.privacy.privacyPolicy)[0]} '),
                              TextSpan(
                                text: t.privacy.privacyPolicy,
                                style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/privacy-policy');
                                  },
                              ),
                              if (t.auth.acceptPrivacyPolicy.split(t.privacy.privacyPolicy).length > 1)
                                TextSpan(text: t.auth.acceptPrivacyPolicy.split(t.privacy.privacyPolicy)[1]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _signUp,
                    child: Text(t.auth.signUp, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonal(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(t.auth.alreadyHaveAccount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
