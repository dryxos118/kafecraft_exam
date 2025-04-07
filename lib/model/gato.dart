class Gato {
  final int gout;
  final int amertume;
  final int teneur;
  final int odorat;

  Gato({
    required this.gout,
    required this.amertume,
    required this.teneur,
    required this.odorat,
  });

  factory Gato.fromMap(Map<String, dynamic> data) {
    return Gato(
      gout: data['gout'] ?? 0,
      amertume: data['amertume'] ?? 0,
      teneur: data['teneur'] ?? 0,
      odorat: data['odorat'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gout': gout,
      'amertume': amertume,
      'teneur': teneur,
      'odorat': odorat,
    };
  }

  Gato copyWith({
    int? gout,
    int? amertume,
    int? teneur,
    int? odorat,
  }) {
    return Gato(
      gout: gout ?? this.gout,
      amertume: amertume ?? this.amertume,
      teneur: teneur ?? this.teneur,
      odorat: odorat ?? this.odorat,
    );
  }
}
