import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/assembly.dart';
import 'package:kafecraft_exam/provider/competition_provider.dart';

class CompetitionActions extends HookConsumerWidget {
  final Assembly? assembly;

  const CompetitionActions({super.key, required this.assembly});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competition = ref.watch(competitionProvider);
    final notifier = ref.read(competitionProvider.notifier);
    final hasOutcome = competition?.outcome != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (hasOutcome) {
            notifier.clearCompetition();
          } else if (competition == null) {
            notifier.createCompetition(assembly!);
          } else {
            notifier.playCompetition();
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: hasOutcome
              ? Colors.amber
              : competition == null
                  ? Colors.green
                  : Colors.brown[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          hasOutcome
              ? "Terminer la compétition"
              : competition == null
                  ? "Ajouter une compétition"
                  : "Lancer la compétition",
        ),
      ),
    );
  }
}
