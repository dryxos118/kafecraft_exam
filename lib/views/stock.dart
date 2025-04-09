import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/provider/stock_provider.dart';
import 'package:kafecraft_exam/widget/stock/assembly_create.dart';
import 'package:kafecraft_exam/widget/stock/assembly_tab.dart';
import 'package:kafecraft_exam/widget/stock/stock_tab.dart';

class Stock extends HookConsumerWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = ref.watch(stockStreamProvider);
    final player = ref.watch(playerNotifier);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) =>
                          AssemblyCreate(stocks: stocks.value!),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Ajouter un Assemblage'),
                ),
                const Spacer(),
                Chip(
                  label: Text('${player?.deeVee ?? 0} deeVee'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          const TabBar(
            tabs: [
              Tab(text: "Stock"),
              Tab(text: "Assemblages"),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                StockTab(),
                AssemblyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
