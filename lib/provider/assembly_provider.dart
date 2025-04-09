import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/data/cafe_data.dart';
import 'package:kafecraft_exam/model/assembly.dart';
import 'package:kafecraft_exam/model/gato.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';

final assemblyStreamProvider =
    StreamNotifierProvider<AssemblyStreamNotifier, List<Assembly>>(
  AssemblyStreamNotifier.new,
);

class AssemblyStreamNotifier extends StreamNotifier<List<Assembly>> {
  @override
  Stream<List<Assembly>> build() async* {
    final player = ref.watch(playerNotifier);
    if (player == null) {
      yield [];
      return;
    }

    final docRef =
        FirebaseFirestore.instance.collection('assemblies').doc(player.id);

    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      await _initializeAssemblyDocument(player.id!);
    }

    yield* docRef.snapshots().map((snap) {
      final data = snap.data();
      final list = (data?['assemblies'] as List<dynamic>? ?? []);
      return list.map((e) => Assembly.fromMap(e)).toList();
    });
  }

  Future<void> _initializeAssemblyDocument(String playerId) async {
    await FirebaseFirestore.instance
        .collection('assemblies')
        .doc(playerId)
        .set({'assemblies': []});
    print("Document 'assemblies' créé pour l'utilisateur: $playerId");
  }

  Future<void> createAssemblageFromStock(
      Map<String, double> selectedGrains) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final totalWeight = selectedGrains.values.reduce((a, b) => a + b);
    if (totalWeight < 1.0) return;

    double totalGout = 0, totalAmertume = 0, totalTeneur = 0, totalOdorat = 0;

    selectedGrains.forEach((name, weight) {
      final cafe = cafeTypes.firstWhere((e) => e.name == name);
      final ratio = weight / totalWeight;

      totalGout += cafe.gato.gout * ratio;
      totalAmertume += cafe.gato.amertume * ratio;
      totalTeneur += cafe.gato.teneur * ratio;
      totalOdorat += cafe.gato.odorat * ratio;
    });

    final gato = Gato(
      gout: totalGout.round(),
      amertume: totalAmertume.round(),
      teneur: totalTeneur.round(),
      odorat: totalOdorat.round(),
    );

    final newAssembly = Assembly(
      name: AssemblyExtension.generateAssemblyName(),
      totalWeight: double.parse(totalWeight.toStringAsFixed(3)),
      gato: gato,
    );

    List<Assembly> updatedAssemblies = [...(state.value ?? []), newAssembly];
    state = AsyncValue.data(updatedAssemblies);

    await FirebaseFirestore.instance
        .collection('assemblies')
        .doc(player.id)
        .set({'assemblies': updatedAssemblies.map((e) => e.toMap()).toList()});

    await ref.read(stockStreamProvider.notifier).consumeGrains(selectedGrains);
  }

  Future<void> registerToCompetition(String assemblyName) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final existing = state.value ?? [];

    final updated = existing.map((a) {
      return a.copyWith(isRegister: a.name == assemblyName);
    }).toList();

    state = AsyncValue.data(updated);

    await FirebaseFirestore.instance
        .collection('assemblies')
        .doc(player.id)
        .update({
      'assemblies': updated.map((a) => a.toMap()).toList(),
    });
  }
}
