import 'cafe_type.dart';

class Plant {
  final CafeType cafeType;
  final DateTime plantedAt;

  Plant({
    required this.cafeType,
    required this.plantedAt,
  });

  factory Plant.fromMap(Map<String, dynamic> data) {
    return Plant(
      cafeType: CafeType.fromMap(data['cafeType']),
      plantedAt: DateTime.parse(data['plantedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cafeType': cafeType.toMap(),
      'plantedAt': plantedAt.toIso8601String(),
    };
  }

  Plant copyWith({
    CafeType? cafeType,
    DateTime? plantedAt,
  }) {
    return Plant(
      cafeType: cafeType ?? this.cafeType,
      plantedAt: plantedAt ?? this.plantedAt,
    );
  }

  DateTime get harvestTime => plantedAt.add(cafeType.growTime);

  bool get isReadyForHarvest => DateTime.now().isAfter(harvestTime);

  Duration get remainingTime {
    final remaining = harvestTime.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  double get growthProgress {
    final elapsed = DateTime.now().difference(plantedAt);
    return elapsed.inSeconds / cafeType.growTime.inSeconds;
  }
}
