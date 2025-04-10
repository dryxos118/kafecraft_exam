import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/assembly.dart';
import 'package:kafecraft_exam/provider/assembly_provider.dart';
import 'package:kafecraft_exam/provider/competition_provider.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

class CompetitionActions extends HookConsumerWidget {
  final Assembly? assembly;

  const CompetitionActions({super.key, required this.assembly});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final competition = ref.watch(competitionProvider);
    final notifier = ref.read(competitionProvider.notifier);
    final hasOutcome = competition?.outcome != null;

    Future<void> handleActionButton() async {
      if (hasOutcome) {
        await notifier.clearCompetition();

        final outcome = competition!.outcome!;
        if (outcome.userWon) {
          await ref.read(playerNotifier.notifier).addOrRemoveDeeVee(10, false);
          await ref.read(playerNotifier.notifier).addGoldSeed(1);
        } else if (outcome.isDraw) {
          await ref.read(playerNotifier.notifier).addOrRemoveDeeVee(5, false);
        } else {
          await ref.read(playerNotifier.notifier).addOrRemoveDeeVee(2, false);
        }
        final assembyName = competition.assembly.name;
        await ref
            .read(assemblyStreamProvider.notifier)
            .removeAssembly(assembyName);
      } else if (competition == null) {
        await notifier.createCompetition(assembly!);
      } else {
        await notifier.playCompetition();
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await handleActionButton();
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
