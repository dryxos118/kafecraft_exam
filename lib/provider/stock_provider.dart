import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/data/cafe_data.dart';
import 'package:kafecraft_exam/model/cafe_type.dart';
import 'package:kafecraft_exam/model/stock.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

final stockStreamProvider =
    StreamNotifierProvider<StockStreamNotifier, List<Stock>>(
  StockStreamNotifier.new,
);

class StockStreamNotifier extends StreamNotifier<List<Stock>> {
  @override
  Stream<List<Stock>> build() async* {
    final player = ref.watch(playerNotifier);
    if (player == null) {
      yield [];
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('stocks').doc(player.id);

    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      await _initializeStockInFirestore(player.id!);
    }

    yield* docRef.snapshots().map((snapshot) {
      if (!snapshot.exists) return [];
      final data = snapshot.data();
      final List<dynamic> stockList = data?['stocks'] ?? [];

      return stockList.map((e) => Stock.fromMap(e)).whereType<Stock>().toList();
    });
  }

  Future<void> _initializeStockInFirestore(String playerId) async {
    final firestore = FirebaseFirestore.instance;

    final defaultStocks = cafeTypes.map((type) {
      return Stock(cafeType: type.name, grainWeight: 0.0).toMap();
    }).toList();

    await firestore.collection('stocks').doc(playerId).set({
      'stocks': defaultStocks,
    });
  }

  Future<void> addGrains(CafeType cafeType) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final dryWeight = cafeType.fruitWeight * (1 - 0.0458);

    final existingStock = state.value!.firstWhere(
      (stock) => stock.cafeType == cafeType.name,
      orElse: () => Stock(cafeType: cafeType.name, grainWeight: 0.0),
    );

    final updatedStock = existingStock.copyWith(
      grainWeight: double.parse(
        (existingStock.grainWeight + dryWeight).toStringAsFixed(3),
      ),
    );

    final updatedStocks = [
      ...state.value!.where((s) => s.cafeType != cafeType.name),
      updatedStock,
    ];

    state = AsyncValue.data(updatedStocks);

    await _saveStockToFirestore(player.id!, updatedStocks);
  }

  Future<void> consumeGrains(Map<String, double> consumedGrains) async {
    final player = ref.read(playerNotifier);
    if (player == null) return;

    final currentStocks = state.value ?? [];

    final updatedStocks = currentStocks.map((stock) {
      final used = consumedGrains[stock.cafeType] ?? 0.0;
      final remaining = (stock.grainWeight - used).clamp(0.0, double.infinity);

      return stock.copyWith(
          grainWeight: double.parse(remaining.toStringAsFixed(3)));
    }).toList();

    state = AsyncValue.data(updatedStocks);

    await _saveStockToFirestore(player.id!, updatedStocks);
  }

  Future<void> _saveStockToFirestore(
      String playerId, List<Stock> stocks) async {
    final firestore = FirebaseFirestore.instance;
    final stockList = stocks.map((stock) => stock.toMap()).toList();

    await firestore.collection('stocks').doc(playerId).set({
      'stocks': stockList,
    });
  }
}
