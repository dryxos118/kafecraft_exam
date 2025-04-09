import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/assembly.dart';
import 'package:kafecraft_exam/provider/assembly_provider.dart';
import 'package:kafecraft_exam/service/snackbar_service.dart';
import 'package:kafecraft_exam/widget/stock/gato_stat.dart';

class AssemblyCard extends HookConsumerWidget {
  final Assembly assembly;

  const AssemblyCard({super.key, required this.assembly});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gato = assembly.gato;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_cafe, size: 28, color: Colors.brown),
                const SizedBox(width: 8),
                Text(
                  assembly.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (assembly.isRegister)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Inscrit",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Poids total : ${assembly.totalWeight.toStringAsFixed(3)} kg',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GatoStat(label: "Goût", value: gato.gout),
                GatoStat(label: "Amertume", value: gato.amertume),
                GatoStat(label: "Teneur", value: gato.teneur),
                GatoStat(label: "Odorat", value: gato.odorat),
              ],
            ),
            if (!assembly.isRegister)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Future.microtask(() => {
                            ref
                                .read(assemblyStreamProvider.notifier)
                                .registerToCompetition(assembly.name)
                          });
                      SnackbarService(context).showSnackbar(
                          title: "Assemblage inscrit au concours",
                          type: Type.succes);
                    },
                    icon: const Icon(Icons.emoji_events),
                    label: const Text('Inscrire au concours'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
