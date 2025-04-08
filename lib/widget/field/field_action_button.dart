import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';
import 'package:kafecraft_exam/provider/time_provider.dart';
import 'package:kafecraft_exam/service/snackbar_service.dart';
import 'package:kafecraft_exam/widget/field/add_plant_dialog.dart';

class FieldActionButton extends HookConsumerWidget {
  final int plantIndex;
  final Field field;

  const FieldActionButton({
    super.key,
    required this.plantIndex,
    required this.field,
  });

  void addPlant(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddPlantDialog(
        plantIndex: plantIndex,
        ref: ref,
      ),
    );
  }

  void harvestPlant(BuildContext context, WidgetRef ref) {
    final plant = field.plants[plantIndex];
    ref.read(selectedFieldProvider.notifier).harvestPlant(plantIndex);
    ref.read(stockStreamProvider.notifier).addGrains(plant.cafeType!);
    SnackbarService(context).showSnackbar(
      title: 'Récolte réussie',
      type: Type.succes,
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(timeUpdatesProvider);

    final plant = field.plants[plantIndex];

    if (plant.cafeType == null) {
      return ElevatedButton.icon(
        onPressed: () => addPlant(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Ajouter',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    if (plant.isReadyForHarvest) {
      return ElevatedButton.icon(
        onPressed: () => harvestPlant(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.grass, color: Colors.white),
        label: const Text('Récolter'),
      );
    }

    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(4),
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
