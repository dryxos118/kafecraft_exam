import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'package:kafecraft_exam/provider/field_provider.dart';

class FieldList extends HookConsumerWidget {
  final List<Field> fields;

  const FieldList({super.key, required this.fields});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vue d\'ensemble des champs'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: fields.length,
        itemBuilder: (context, index) {
          final field = fields[index];
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
                  'Plantes: ${field.plants.length}/4',
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
      ),
    );
  }
}
