import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';
import 'package:kafecraft_exam/widget/field/field_card.dart';

class FieldPage extends HookConsumerWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final field = ref.watch(selectedFieldProvider);

    if (field == null) {
      return const Center(child: Text("Aucun champ sélectionné"));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Champ: ${field.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: field.plants.length,
              itemBuilder: (context, index) {
                return FieldCard(index: index);
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => context.go("/farme"),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour'),
          ),
        ],
      ),
    );
  }
}
