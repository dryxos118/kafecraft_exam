import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/assembly.dart';
import 'package:kafecraft_exam/model/competition_dto.dart';
import 'package:kafecraft_exam/model/gato.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

final competitionProvider =
    StateNotifierProvider<CompetitionNotifier, CompetitionState?>((ref) {
  return CompetitionNotifier(ref);
});

class CompetitionNotifier extends StateNotifier<CompetitionState?> {
  final Ref ref;
  final Random _random = Random();

  CompetitionNotifier(this.ref) : super(null);

  Future<void> createCompetition(Assembly assembly) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final epreuves = [...EpreuveType.values]..shuffle();
    final selected = epreuves.take(2).toList();

    final competition = CompetitionState(
      epreuves: selected,
      assembly: assembly,
    );

    state = competition;

    await FirebaseFirestore.instance
        .collection('competitions')
        .doc(player.id)
        .set(competition.toMap());
  }

  Future<void> loadCompetition() async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('competitions')
        .doc(player.id)
        .get();

    if (doc.exists) {
      state = CompetitionState.fromMap(doc.data()!);
    }
  }

  Future<void> playCompetition() async {
    final player = ref.read(playerNotifier);
    if (player == null || state == null) return;

    final Assembly userAssembly = state!.assembly;
    final Assembly botAssembly = _generateRandomBotAssembly();

    final List<EpreuveScore> scores = [];
    double totalUser = 0;
    double totalBot = 0;

    for (var e in state!.epreuves) {
      final userScore = _calculateScore(e, userAssembly);
      final botScore = _calculateScore(e, botAssembly);
      scores.add(EpreuveScore(
        type: e,
        userScore: double.parse(userScore.toStringAsFixed(2)),
        botScore: double.parse(botScore.toStringAsFixed(2)),
      ));
      totalUser += userScore;
      totalBot += botScore;
    }

    final outcome = CompetitionOutcome(
      userWon: totalUser > totalBot,
      isDraw: totalUser == totalBot,
      scores: scores,
    );

    state = state!.copyWith(outcome: outcome);

    await FirebaseFirestore.instance
        .collection('competitions')
        .doc(player.id)
        .update(state!.toMap());
  }

  Future<void> clearCompetition() async {
    final player = ref.read(playerNotifier);
    if (player == null) return;
    await FirebaseFirestore.instance
        .collection('competitions')
        .doc(player.id)
        .delete();
    state = null;
  }

  Assembly _generateRandomBotAssembly() {
    return Assembly(
      name: "BOT-${_random.nextInt(9999)}",
      totalWeight: 1.0,
      gato: Gato(
        gout: _random.nextInt(100),
        amertume: _random.nextInt(100),
        teneur: _random.nextInt(100),
        odorat: _random.nextInt(100),
      ),
    );
  }

  double _calculateScore(EpreuveType type, Assembly a) {
    final g = a.gato;
    final chance = _random.nextDouble();
    switch (type) {
      case EpreuveType.tasse:
        return 0.8 * g.gout +
            g.teneur +
            0.3 * g.odorat +
            0.1 * g.amertume +
            chance;
      case EpreuveType.kafetiere:
        return 0.1 * g.gout +
            0.5 * g.teneur +
            0.8 * g.odorat +
            0.1 * g.amertume +
            chance;
      case EpreuveType.degustation:
        return 0.4 * g.teneur +
            0.8 * g.gout +
            0.4 * g.odorat +
            0.4 * g.amertume +
            chance;
    }
  }
}
