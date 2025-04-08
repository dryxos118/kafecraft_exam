import 'plant.dart';

class Field {
  final String name;
  final List<Plant> plants;

  Field({
    required this.name,
    required this.plants,
  });

  factory Field.empty(String name) {
    // Initialiser avec 4 plantes vides
    List<Plant> emptyPlants = List.generate(4, (_) => Plant.empty());
    return Field(name: name, plants: emptyPlants);
  }

  factory Field.fromMap(Map<String, dynamic> data) {
    return Field(
      name: data["name"] ?? 'Unknown',
      plants: (data['plants'] as List<dynamic>?)
              ?.map((e) => Plant.fromMap(e as Map<String, dynamic>?))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'plants': plants.map((p) => p.toMap()).toList(),
    };
  }

  Field copyWith({
    String? name,
    List<Plant>? plants,
  }) {
    return Field(
      name: name ?? this.name,
      plants: plants ?? this.plants,
    );
  }
}
