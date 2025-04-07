import 'package:flutter/material.dart';
import 'package:kafecraft_exam/model/field.dart';

class FieldStatus extends StatelessWidget {
  final Field field;

  const FieldStatus({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    if (field.plants.isEmpty) {
      return const Text(
        'Aucune plante',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    final plant = field.plants.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${plant.cafeType.avatar} ${plant.cafeType.name}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        plant.isReadyForHarvest
            ? const Text(
                'Prêt à récolter',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            : const Text(
                'En cours de pousse',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.w500),
              ),
      ],
    );
  }
}
