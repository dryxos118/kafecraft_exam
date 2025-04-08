import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/constants/constants.dart';
import 'package:kafecraft_exam/widget/register/register_form.dart';

class Register extends HookConsumerWidget {
  const Register({super.key});

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
              child: RegisterForm(),
            ),
            TextButton(
              onPressed: () {
                context.go("/login");
              },
              child: const Text('Déjà un compte ? Connectez-vous'),
            )
          ],
        ),
      ),
    );
  }
}
