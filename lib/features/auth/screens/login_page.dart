import 'dart:async';

import 'package:evnttrackr/features/auth/screens/signup_page.dart';
import 'package:evnttrackr/theme/app_colors.dart';
import 'package:evnttrackr/utils/notification_helper.dart';
import 'package:evnttrackr/widgets/password_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:evnttrackr/i18n/strings.g.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  Future<void> _signIn() async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        TextInput.finishAutofillContext();
        Navigator.pushReplacementNamed(context, '/');
      }
    } on AuthException catch (error) {
      if (mounted) {
        debugPrint(error.message);
        NotificationHelper.showError(context, t.errors.loginerror);
      }
    }
  }

  Future<void> _forgotPassword() async {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 8,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                t.auth.forgotPassword,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: t.auth.email,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return t.auth.pleaseEnterYourEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.common.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final messenger = ScaffoldMessenger.of(context);

                      if (formKey.currentState!.validate()) {
                        try {
                          await Supabase.instance.client.auth.resetPasswordForEmail(
                            emailController.text.trim(),
                            redirectTo: 'evnttrackr://reset-password'
                          );
                          if (mounted) {
                            navigator.pop();
                            NotificationHelper.showSuccess(context, t.auth.passwordResetLinkSent);
                          }
                        } on AuthException catch (e) {
                          if (mounted) {
                            navigator.pop();
                            NotificationHelper.showError(context, e.message);
                          }
                        }
                      }
                    },
                    child: Text(t.common.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColor = theme.colorScheme.primary;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child:ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: 600
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        const Spacer(flex: 2),
                        Align(
                          alignment: Alignment.center,
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: SvgPicture.asset("assets/images/evnt-trackr.svg"),
                          ),
                        ),
                        const Spacer(),
                        AutofillGroup(
                          child: Column(
                            children: [
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: t.auth.email,
                                  ),
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                              ),
                              const SizedBox(height: 16),
                              PasswordFormField(
                                controller: _passwordController,
                                labelText: t.auth.password,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton(
                              onPressed: _signIn,
                              child: Text(t.auth.signIn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignupPage()),
                                );
                              },
                              child: Text(t.auth.dontHaveAccount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: _forgotPassword,
                          child: Text(t.auth.forgotPassword),
                        ),
                        const Spacer(flex: 2),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(text: '${t.about.createdBy} '),
                              TextSpan(
                                text: 'ToDelattre',
                                style: TextStyle(decoration: TextDecoration.underline, color: customColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchUrl(Uri.parse('https://ko-fi.com/ToDelattre'));
                                  },
                              ),
                              TextSpan(text: ' - ${t.about.version} $_version'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
