import 'gato.dart';

class CafeType {
  final String name;
  final String avatar;
  final Duration growTime;
  final int costDeeVee;
  final double fruitWeight;
  final Gato gato;

  CafeType({
    required this.name,
    required this.avatar,
    required this.growTime,
    required this.costDeeVee,
    required this.fruitWeight,
    required this.gato,
  });

  factory CafeType.fromMap(Map<String, dynamic> data) {
    return CafeType(
      name: data['name'],
      avatar: data['avatar'],
      growTime: Duration(minutes: data['growTime'] ?? 1),
      costDeeVee: data['costDeeVee'] ?? 1,
      fruitWeight: (data['fruitWeight'] ?? 0.0).toDouble(),
      gato: Gato.fromMap(data['gato']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
      'growTime': growTime.inMinutes,
      'costDeeVee': costDeeVee,
      'fruitWeight': fruitWeight,
      'gato': gato.toMap(),
    };
  }

  CafeType copyWith({
    String? name,
    String? avatar,
    Duration? growTime,
    int? costDeeVee,
    double? fruitWeight,
    Gato? gato,
  }) {
    return CafeType(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      growTime: growTime ?? this.growTime,
      costDeeVee: costDeeVee ?? this.costDeeVee,
      fruitWeight: fruitWeight ?? this.fruitWeight,
      gato: gato ?? this.gato,
    );
  }
}
