import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'field_status.dart';
import 'field_action_button.dart';

class FieldCard extends HookConsumerWidget {
  final int index;
  final Field field;

  const FieldCard({super.key, required this.index, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
          children: [
            // Titre avec marge réduite
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Champ ${index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FieldStatus(field: field),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight, // Alignement à gauche
                  child: FieldActionButton(index: index, field: field),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
