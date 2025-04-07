import 'package:flutter/material.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'field_card.dart';

class FieldList extends StatelessWidget {
  final List<Field> fields;

  const FieldList({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        final field = fields[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: FieldCard(index: index, field: field),
        );
      },
    );
  }
}
