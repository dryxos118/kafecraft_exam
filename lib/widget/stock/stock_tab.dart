import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';
import 'package:kafecraft_exam/widget/stock/stock_card.dart';

class StockTab extends HookConsumerWidget {
  const StockTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(stockStreamProvider);

    return stocksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text("Erreur lors du chargement : $error"),
      ),
      data: (stocks) {
        if (stocks.isEmpty) {
          return const Center(child: Text("Aucun stock disponible."));
        }

        final sortedStocks = [...stocks]
          ..sort((a, b) => a.cafeType.compareTo(b.cafeType));

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: sortedStocks.length,
          itemBuilder: (context, index) {
            final stock = sortedStocks[index];
            return StockCard(stock: stock);
          },
        );
      },
    );
  }
}
