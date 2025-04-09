import 'package:kafecraft_exam/model/assembly.dart';

enum EpreuveType {
  tasse,
  kafetiere,
  degustation;

  String get label {
    switch (this) {
      case EpreuveType.tasse:
        return "Test de la tasse";
      case EpreuveType.kafetiere:
        return "Kafetière";
      case EpreuveType.degustation:
        return "Dégustation";
    }
  }
}

class EpreuveScore {
  final EpreuveType type;
  final double userScore;
  final double botScore;

  EpreuveScore({
    required this.type,
    required this.userScore,
    required this.botScore,
  });

  Map<String, dynamic> toMap() => {
        'type': type.name,
        'userScore': userScore,
        'botScore': botScore,
      };

  factory EpreuveScore.fromMap(Map<String, dynamic> data) => EpreuveScore(
        type: EpreuveType.values.byName(data['type']),
        userScore: (data['userScore'] ?? 0).toDouble(),
        botScore: (data['botScore'] ?? 0).toDouble(),
      );
}

class CompetitionOutcome {
  final bool userWon;
  final bool isDraw;
  final List<EpreuveScore> scores;

  CompetitionOutcome({
    required this.userWon,
    required this.isDraw,
    required this.scores,
  });

  Map<String, dynamic> toMap() => {
        'userWon': userWon,
        'isDraw': isDraw,
        'scores': scores.map((e) => e.toMap()).toList(),
      };

  factory CompetitionOutcome.fromMap(Map<String, dynamic> data) =>
      CompetitionOutcome(
        userWon: data['userWon'],
        isDraw: data['isDraw'],
        scores: (data['scores'] as List<dynamic>)
            .map((e) => EpreuveScore.fromMap(e))
            .toList(),
      );
}

class CompetitionState {
  final List<EpreuveType> epreuves;
  final Assembly assembly;
  final CompetitionOutcome? outcome;

  CompetitionState({
    required this.epreuves,
    required this.assembly,
    this.outcome,
  });

  Map<String, dynamic> toMap() => {
        'epreuves': epreuves.map((e) => e.name).toList(),
        'assembly': assembly.toMap(),
        'outcome': outcome?.toMap(),
      };

  factory CompetitionState.fromMap(Map<String, dynamic> data) =>
      CompetitionState(
        epreuves: (data['epreuves'] as List<dynamic>)
            .map((e) => EpreuveType.values.byName(e))
            .toList(),
        assembly: Assembly.fromMap(data['assembly']),
        outcome: data['outcome'] != null
            ? CompetitionOutcome.fromMap(data['outcome'])
            : null,
      );

  CompetitionState copyWith({
    List<EpreuveType>? epreuves,
    Assembly? assembly,
    CompetitionOutcome? outcome,
  }) =>
      CompetitionState(
        epreuves: epreuves ?? this.epreuves,
        assembly: assembly ?? this.assembly,
        outcome: outcome ?? this.outcome,
      );
}
