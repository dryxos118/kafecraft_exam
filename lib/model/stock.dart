class Stock {
  final String cafeType;
  final double grainWeight;

  Stock({required this.cafeType, required this.grainWeight});

  factory Stock.fromMap(Map<String, dynamic> data) {
    return Stock(
      cafeType: data['cafeType'],
      grainWeight: (data['grainWeight'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cafeType': cafeType,
      'grainWeight': grainWeight,
    };
  }

  Stock copyWith({String? cafeType, double? grainWeight}) {
    return Stock(
      cafeType: cafeType ?? this.cafeType,
      grainWeight: grainWeight ?? this.grainWeight,
    );
  }
}
