import 'dart:math';
import 'plant.dart';

enum FieldSpeciality {
  rendementX2,
  tempsDiv2,
  neutre,
}

extension FieldSpecialityExtension on FieldSpeciality {
  String toFirestoreString() {
    return toString().split('.').last;
  }

  static FieldSpeciality fromFirestoreString(String value) {
    return FieldSpeciality.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => FieldSpeciality.neutre,
    );
  }

  static FieldSpeciality getRandom() {
    final randomIndex = Random().nextInt(FieldSpeciality.values.length);
    return FieldSpeciality.values[randomIndex];
  }
}

class Field {
  final String name;
  final List<Plant> plants;
  final FieldSpeciality speciality;

  Field({
    required this.name,
    required this.plants,
    required this.speciality,
  });

  factory Field.empty(String name) {
    List<Plant> emptyPlants = List.generate(4, (_) => Plant.empty());
    FieldSpeciality randomSpeciality = FieldSpecialityExtension.getRandom();
    return Field(name: name, plants: emptyPlants, speciality: randomSpeciality);
  }

  factory Field.fromMap(Map<String, dynamic> data) {
    return Field(
      name: data["name"] ?? 'Unknown',
      plants: (data['plants'] as List<dynamic>?)
              ?.map((e) => Plant.fromMap(e as Map<String, dynamic>?))
              .toList() ??
          [],
      speciality: FieldSpecialityExtension.fromFirestoreString(
          data['speciality'] ?? 'neutre'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plants': plants.map((p) => p.toMap()).toList(),
      'speciality': speciality.toFirestoreString(),
    };
  }

  Field copyWith({
    String? name,
    List<Plant>? plants,
    FieldSpeciality? speciality,
  }) {
    return Field(
      name: name ?? this.name,
      plants: plants ?? this.plants,
      speciality: speciality ?? this.speciality,
    );
  }
}
