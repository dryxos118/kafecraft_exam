import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';
import 'package:kafecraft_exam/provider/time_provider.dart';

class FieldList extends HookConsumerWidget {
  final List<Field> fields;

  const FieldList({super.key, required this.fields});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(timeProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        final field = fields[index];

        final readyToHarvest =
            field.plants.where((plant) => plant.isReadyForHarvest).length;

        final inProgress = field.plants
            .where(
                (plant) => plant.cafeType != null && !plant.isReadyForHarvest)
            .length;

        final emptySlots =
            field.plants.where((plant) => plant.cafeType == null).length;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                field.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '\n- Vides: $emptySlots\n- En cours: $inProgress\n- Prêtes à récolter: $readyToHarvest',
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(selectedFieldProvider.notifier).setField(field);
                context.go('/farme/detail');
              },
            ),
          ),
        );
      },
    );
  }
}
