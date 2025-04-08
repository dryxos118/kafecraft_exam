import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';

class Stock extends HookConsumerWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = ref.watch(stockStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Stock de Grains')),
      body: stocks.value!.isEmpty
          ? const Center(child: Text('Aucun stock enregistré'))
          : ListView.builder(
              itemCount: stocks.value?.length,
              itemBuilder: (context, index) {
                final stock = stocks.value![index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: Text(stock?.cafeType ?? 'Inconnu'),
                    title: Text(
                      'Grains secs: ${stock?.grainWeight.toStringAsFixed(3) ?? '0.000'} g',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
