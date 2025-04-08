import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/data/cafe_data.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';
import 'package:kafecraft_exam/service/snackbar_service.dart';

class AddPlantDialog extends HookConsumerWidget {
  final int plantIndex;
  final WidgetRef ref;

  const AddPlantDialog({
    super.key,
    required this.plantIndex,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Titre fixe en haut
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Sélectionner une plante',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1),

            // Contenu défilant au centre
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: cafeTypes.map((cafeType) {
                      return _buildPlantCard(context, cafeType);
                    }).toList(),
                  ),
                ),
              ),
            ),

            const Divider(height: 1),

            // Bouton "Fermer" fixe en bas
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Fermer',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, cafeType) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, cafeType),
            const SizedBox(height: 8),
            _buildMainInfoRow(cafeType),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(selectedFieldProvider.notifier).addPlant(
                        plantIndex,
                        cafeType,
                      );
                  Navigator.of(context).pop();
                  SnackbarService(context).showSnackbar(
                    title: '${cafeType.name} ajouté au champ',
                    type: Type.succes,
                  );
                },
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  'Planter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, cafeType) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green.shade100,
          child: Text(
            cafeType.avatar,
            style: const TextStyle(fontSize: 28),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          cafeType.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfoRow(cafeType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoTile(Icons.timer, '${cafeType.growTime.inMinutes} min'),
        _buildInfoTile(Icons.monetization_on, '${cafeType.costDeeVee} DeeVee'),
        _buildInfoTile(
            Icons.scale, '${cafeType.fruitWeight.toStringAsFixed(2)} g'),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.orange),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
