import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/assembly_provider.dart';
import 'package:kafecraft_exam/provider/competition_provider.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/widget/competition/competition_actions.dart';
import 'package:kafecraft_exam/widget/competition/epreuve_list.dart';
import 'package:kafecraft_exam/widget/stock/assembly_card.dart';

class Competition extends HookConsumerWidget {
  const Competition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblies = ref.watch(assemblyStreamProvider).value ?? [];
    final player = ref.watch(playerNotifier);
    final competition = ref.watch(competitionProvider);

    final assembly = assemblies.where((a) => a.isRegister).isNotEmpty
        ? assemblies.firstWhere((a) => a.isRegister)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Text(
                'Compétition',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Chip(
                label: Text('${player?.deeVee ?? 0} DeeVee'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: assembly == null
                ? const Center(
                    child: Text(
                      "Aucun assemblage inscrit à la compétition.",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AssemblyCard(assembly: assembly),
                      const SizedBox(height: 16),
                      if (competition != null) const EpreuveList(),
                      const Spacer(),
                      CompetitionActions(assembly: assembly),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
