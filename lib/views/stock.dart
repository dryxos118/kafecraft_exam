import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';
import 'package:kafecraft_exam/widget/stock/stock_card.dart';

class Stock extends HookConsumerWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = ref.watch(stockStreamProvider);

    return stocks.value == null || stocks.value!.isEmpty
        ? const Center(child: Text('Aucun stock enregistré'))
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: stocks.value?.length,
            itemBuilder: (context, index) {
              final stock = stocks.value![index];
              if (stock == null) return const SizedBox();
              return StockCard(stock: stock);
            },
          );
  }
}
