import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';
import 'field_status.dart';
import 'field_action_button.dart';

class FieldCard extends HookConsumerWidget {
  final int index;

  const FieldCard({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupérer la plante mise à jour via le provider
    final field = ref.watch(selectedFieldProvider);
    if (field == null) {
      return const SizedBox(); // Retourner un widget vide si aucun champ n'est sélectionné
    }

    // Récupérer la plante actuelle à partir du champ sélectionné
    final plant = field.plants[index];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plante ${index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                // Statut de la plante (géré dynamiquement)
                FieldStatus(plant: plant),
                const Spacer(),
                // Bouton d'action (géré dynamiquement)
                FieldActionButton(plantIndex: index, field: field),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
