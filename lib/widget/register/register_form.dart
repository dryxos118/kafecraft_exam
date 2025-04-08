import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

class RegisterForm extends HookConsumerWidget {
  RegisterForm({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState(true);

    void togglePasswordVisibility() {
      obscureText.value = !obscureText.value;
    }

    Future<void> submitForm(VoidCallback onSubmited) async {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();

        await ref.read(playerNotifier.notifier).registerInFirebase(
              emailController.text,
              passwordController.text,
              firstNameController.text,
              lastNameController.text,
            );

        onSubmited();
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'Prénom',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Veuillez entrer votre prénom'
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Nom',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Veuillez entrer votre nom'
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              controller: passwordController,
              obscureText: obscureText.value,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: IconButton(
                  icon: Icon(obscureText.value
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: togglePasswordVisibility,
                ),
              ),
              validator: (value) => value == null || value.length < 6
                  ? 'Le mot de passe doit contenir au moins 6 caractères'
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => submitForm(() => context.go("/farme")),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("S'inscrire"),
          ),
        ],
      ),
    );
  }
}
