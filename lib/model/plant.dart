import 'cafe_type.dart';

class Plant {
  final CafeType? cafeType;
  final DateTime? plantedAt;

  Plant({
    required this.cafeType,
    required this.plantedAt,
  });

  /// Constructeur vide pour les plantes non initialisées
  factory Plant.empty() {
    return Plant(cafeType: null, plantedAt: null);
  }

  factory Plant.fromMap(Map<String, dynamic>? data) {
    if (data == null || data['cafeType'] == null || data['plantedAt'] == null) {
      return Plant.empty();
    }

    return Plant(
      cafeType: CafeType.fromMap(data['cafeType']),
      plantedAt: DateTime.tryParse(data['plantedAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    if (cafeType == null || plantedAt == null) {
      return {};
    }

    return {
      'cafeType': cafeType!.toMap(),
      'plantedAt': plantedAt!.toIso8601String(),
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

  DateTime get harvestTime => plantedAt!.add(cafeType!.growTime);

  bool get isReadyForHarvest =>
      plantedAt != null && DateTime.now().isAfter(harvestTime);

  Duration get remainingTime {
    if (plantedAt == null || cafeType == null) return Duration.zero;
    final remaining = harvestTime.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  double get growthProgress {
    if (plantedAt == null || cafeType == null) return 0.0;
    final elapsed = DateTime.now().difference(plantedAt!);
    return (elapsed.inSeconds / cafeType!.growTime.inSeconds).clamp(0.0, 1.0);
  }

  bool get isEmpty => cafeType == null || plantedAt == null;
}
