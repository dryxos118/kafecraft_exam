// field_action_button.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'package:kafecraft_exam/provider/exploitation_provider.dart';
import 'package:kafecraft_exam/provider/time_provider.dart';
import 'add_plant_dialog.dart';

class FieldActionButton extends HookConsumerWidget {
  final int index;
  final Field field;

  const FieldActionButton({
    super.key,
    required this.index,
    required this.field,
  });

  void harvestPlant(BuildContext context, WidgetRef ref) {
    ref.read(exploitationProvider.notifier).removePlant(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Récolté: ${field.plants.first.cafeType.name}')),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écoute les mises à jour temporelles (rafraîchit toutes les secondes)
    ref.watch(timeUpdatesProvider);

    final plant = field.plants.firstOrNull;

    if (plant == null) {
      return ElevatedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddPlantDialog(fieldIndex: index, ref: ref),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomRight: Radius.circular(13),
              ),
            )),
        child: const Text('Ajouter'),
      );
    }

    if (plant.isReadyForHarvest) {
      return ElevatedButton(
        onPressed: () => harvestPlant(context, ref),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomRight: Radius.circular(13),
              ),
            )),
        child: const Text('Récolter'),
      );
    }

    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: plant.growthProgress.clamp(0.0, 1.0),
            strokeWidth: 4,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
          Text(
            formatDuration(plant.remainingTime),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
