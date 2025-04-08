import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/stock.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

final stockStreamProvider =
    StreamNotifierProvider<StockStreamNotifier, List<Stock?>>(
  StockStreamNotifier.new,
);

class StockStreamNotifier extends StreamNotifier<List<Stock?>> {
  @override
  Stream<List<Stock?>> build() {
    final player = ref.watch(playerNotifier);
    if (player == null) return const Stream.empty();

    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('stocks').doc(player.id);

    return collection.snapshots().map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data();
      final List<dynamic> stockList = data?['stocks'] ?? [];
      return stockList
          .where((e) => e != null)
          .map((e) => Stock.fromMap(e))
          .toList();
    });
  }

  Future<void> addGrains(String cafeType, double fruitWeight) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final dryWeight = fruitWeight * (1 - 0.0458);

    final existingStock = state.value?.firstWhere(
      (stock) => stock?.cafeType == cafeType,
      orElse: () => Stock(cafeType: cafeType, grainWeight: 0.0),
    );

    final updatedStock = existingStock?.copyWith(
      grainWeight: (existingStock.grainWeight) + dryWeight,
    );

    final currentStocks = state.value ?? [];

    final updatedStocks = [
      ...currentStocks.where((stock) => stock?.cafeType != cafeType),
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
