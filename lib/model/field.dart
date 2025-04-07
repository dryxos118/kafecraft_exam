import 'plant.dart';

class Field {
  final List<Plant> plants;

  Field({
    required this.plants,
  });

  factory Field.fromMap(Map<String, dynamic> data) {
    return Field(
      plants: (data['plants'] as List<dynamic>)
          .map((e) => Plant.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'plants': plants.map((p) => p.toMap()).toList(),
    };
  }

  Field copyWith({
    List<Plant>? plants,
  }) {
    return Field(
      plants: plants ?? this.plants,
    );
  }
}
