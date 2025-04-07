import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/data/cafe_data.dart';
import 'package:kafecraft_exam/model/plant.dart';
import 'package:kafecraft_exam/provider/exploitation_provider.dart';

class AddPlantDialog extends StatelessWidget {
  final int fieldIndex;
  final WidgetRef ref;

  const AddPlantDialog(
      {super.key, required this.fieldIndex, required this.ref});

  void _showConfirmationDialog(BuildContext context, cafeType) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      cafeType.avatar,
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        cafeType.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                _buildInfoRow('🌱 Temps de croissance',
                    '${cafeType.growTime.inMinutes} minutes'),
                _buildInfoRow('💰 Coût', '${cafeType.costDeeVee} DeeVee'),
                _buildInfoRow('🍇 Poids des fruits',
                    '${cafeType.fruitWeight.toStringAsFixed(3)} g'),
                const SizedBox(height: 12),
                const Text(
                  'Caractéristiques GATO',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('🍬 Goût', '${cafeType.gato.gout} / 100'),
                _buildInfoRow(
                    '🌶️ Amertume', '${cafeType.gato.amertume} / 100'),
                _buildInfoRow('☕ Teneur', '${cafeType.gato.teneur} / 100'),
                _buildInfoRow('👃 Odorat', '${cafeType.gato.odorat} / 100'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Annuler',
                          style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(exploitationProvider.notifier)
                            .updateFieldWithPlant(
                              fieldIndex,
                              Plant(
                                  cafeType: cafeType,
                                  plantedAt: DateTime.now()),
                            );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${cafeType.name} ajouté au champ')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Confirmer'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(value,
              style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Choisir une plante',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: ListView.builder(
          itemCount: cafeTypes.length,
          itemBuilder: (context, index) {
            final cafeType = cafeTypes[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                leading: Text(
                  cafeType.avatar,
                  style: const TextStyle(fontSize: 30),
                ),
                title: Text(
                  cafeType.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('⏱️ Temps: ${cafeType.growTime.inMinutes} min'),
                    Text('💰 Coût: ${cafeType.costDeeVee} DeeVee'),
                    Text(
                        '🍇 Fruits: ${cafeType.fruitWeight.toStringAsFixed(3)} g'),
                  ],
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () => _showConfirmationDialog(context, cafeType),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fermer', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
