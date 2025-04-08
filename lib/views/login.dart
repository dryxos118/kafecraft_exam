import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/constants/constants.dart';
import 'package:kafecraft_exam/views/register.dart';
import 'package:kafecraft_exam/widget/login/login_form.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            ClipRRect(
              borderRadius: generalBorderRadius(),
              child: Image.asset("assets/logo.png",
                  height: 300, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LoginForm(),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: const Text('Pas encore de compte ? Inscrivez-vous'),
            )
          ],
        ),
      ),
    );
  }
}
