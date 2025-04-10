import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/competition_dto.dart';
import 'package:kafecraft_exam/provider/competition_provider.dart';

class EpreuveList extends HookConsumerWidget {
  const EpreuveList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comp = ref.watch(competitionProvider);

    if (comp == null) return const SizedBox();

    final outcome = comp.outcome;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Épreuves",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...comp.epreuves.map((epreuve) {
          final score = comp.outcome?.scores.firstWhere(
            (s) => s.type == epreuve,
            orElse: () =>
                EpreuveScore(type: epreuve, userScore: 0.0, botScore: 0.0),
          );

          final double user = score?.userScore ?? 0.0;
          final double bot = score?.botScore ?? 0.0;

          Icon? trailingIcon;
          if (user > bot) {
            trailingIcon = const Icon(Icons.check_circle, color: Colors.green);
          } else if (bot > user) {
            trailingIcon = const Icon(Icons.cancel, color: Colors.red);
          } else {
            trailingIcon =
                const Icon(Icons.remove_circle_outline, color: Colors.grey);
          }

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.sports_esports),
              title: Text(epreuve.label),
              subtitle: Text(
                  "Toi: ${user.toStringAsFixed(1)} | Bot: ${bot.toStringAsFixed(1)}"),
              trailing: trailingIcon,
            ),
          );
        }),
        const SizedBox(height: 16),
        if (outcome != null)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: outcome.isDraw
                    ? Colors.blue.shade100
                    : outcome.userWon
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                outcome.isDraw
                    ? "🤝 Match nul (+5 DeeVee)"
                    : outcome.userWon
                        ? "🏆 Victoire (+10 DeeVee)"
                        : "😓 Défaite (+2 DeeVee)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: outcome.isDraw
                      ? Colors.blue.shade800
                      : outcome.userWon
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
