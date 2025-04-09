import 'dart:math';

import 'package:kafecraft_exam/model/gato.dart';

class Assembly {
  final String name;
  final double totalWeight;
  final Gato gato;
  final bool isRegister;

  Assembly({
    required this.name,
    required this.totalWeight,
    required this.gato,
    this.isRegister = false,
  });

  factory Assembly.fromMap(Map<String, dynamic> data) {
    return Assembly(
      name: data['name'],
      totalWeight: (data['totalWeight'] ?? 0.0).toDouble(),
      gato: Gato.fromMap(data['gato']),
      isRegister: data['isRegister'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'totalWeight': totalWeight,
      'gato': gato.toMap(),
      'isRegister': isRegister,
    };
  }

  Assembly copyWith({
    String? name,
    double? totalWeight,
    Gato? gato,
    bool? isRegister,
  }) {
    return Assembly(
      name: name ?? this.name,
      totalWeight: totalWeight ?? this.totalWeight,
      gato: gato ?? this.gato,
      isRegister: isRegister ?? this.isRegister,
    );
  }
}

extension AssemblyExtension on Assembly {
  static String generateAssemblyName() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final rand = Random();
    final length = rand.nextBool() ? 4 : 5;

    return List.generate(length, (_) => letters[rand.nextInt(letters.length)])
        .join();
  }
}
