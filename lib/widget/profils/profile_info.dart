import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/service/snackbar_service.dart';

class ProfileInfo extends HookConsumerWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifier);
    final formKey = GlobalKey<FormState>();

    final emailController = useTextEditingController(text: player?.email!);
    final firstNameController =
        useTextEditingController(text: player?.firstName ?? '');
    final lastNameController =
        useTextEditingController(text: player?.lastName ?? '');

    if (player == null) {
      return const Center(child: Text('Aucun joueur trouvé.'));
    }

    void saveProfile() {
      if (formKey.currentState?.validate() ?? false) {
        ref.read(playerNotifier.notifier).updatePlayerInfo(
            firstNameController.text, lastNameController.text);
        SnackbarService(context).showSnackbar(
            title: "Informations enregistrées", type: Type.succes);
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      labelStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    style: const TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le prénom ne peut pas être vide';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    style: const TextStyle(fontSize: 18),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le nom ne peut pas être vide';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Enregistrer', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
