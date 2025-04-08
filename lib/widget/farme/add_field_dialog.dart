import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/exploitation_provider.dart';

class AddFieldDialog extends StatelessWidget {
  final WidgetRef ref;

  const AddFieldDialog({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return AlertDialog(
      title: const Text('Ajouter un champ'),
      content: TextField(
        controller: nameController,
        decoration: const InputDecoration(hintText: 'Entrez le nom'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            String name = nameController.text;
            ref.read(exploitationProvider.notifier).addField(name);
            Navigator.of(context).pop();
          },
          child: const Text('Soumettre'),
        ),
      ],
    );
  }
}
