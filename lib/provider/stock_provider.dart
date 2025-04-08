import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/cafe_type.dart';
import 'package:kafecraft_exam/model/stock.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

final stockStreamProvider =
    StreamNotifierProvider<StockStreamNotifier, List<Stock?>>(
  StockStreamNotifier.new,
);

class StockStreamNotifier extends StreamNotifier<List<Stock?>> {
  @override
  Stream<List<Stock?>> build() async* {
    final player = ref.watch(playerNotifier);
    if (player == null) {
      yield [];
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('stocks').doc(player.id);

    // Vérifier l'existence du document stock
    final snapshot = await collection.get();
    if (!snapshot.exists) {
      // Créer le document vide si nécessaire
      await _initializeStockInFirestore(player.id!);
    }

    // Écouter les mises à jour du document stock
    yield* collection.snapshots().map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data();
      final List<dynamic> stockList = data?['stocks'] ?? [];
      return stockList
          .where((e) => e != null)
          .map((e) => Stock.fromMap(e))
          .toList();
    });
  }

  Future<void> _initializeStockInFirestore(String playerId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('stocks').doc(playerId).set({
      'stocks': [], // Liste vide pour l'initialisation
    });
    print("Stock document créé pour l'utilisateur: $playerId");
  }

  Future<void> addGrains(CafeType cafeType) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final dryWeight = cafeType.fruitWeight * (1 - 0.0458);

    final existingStock = state.value?.firstWhere(
      (stock) => stock?.cafeType == cafeType.name,
      orElse: () => Stock(cafeType: cafeType.name, grainWeight: 0.0),
    );

    final updatedStock = existingStock?.copyWith(
      grainWeight: (existingStock.grainWeight) + dryWeight,
    );

    final currentStocks = state.value ?? [];

    final updatedStocks = [
      ...currentStocks.where((stock) => stock?.cafeType != cafeType.name),
      updatedStock,
    ].whereType<Stock?>().toList();

    state = AsyncValue.data(updatedStocks);

    await _saveStockToFirestore(player.id!, updatedStocks);
  }

  Future<void> _saveStockToFirestore(
      String playerId, List<Stock?> stocks) async {
    final firestore = FirebaseFirestore.instance;
    final stockList = stocks
        .where((stock) => stock != null)
        .map((stock) => stock?.toMap())
        .toList();

    await firestore.collection('stocks').doc(playerId).set({
      'stocks': stockList,
    });
  }
}
