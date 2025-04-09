import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/stock.dart';
import 'package:kafecraft_exam/provider/assembly_provider.dart';
import 'package:kafecraft_exam/widget/stock/assembly_buttons.dart';
import 'package:kafecraft_exam/widget/stock/assembly_slider.dart';

class AssemblyCreate extends HookConsumerWidget {
  final List<Stock> stocks;

  const AssemblyCreate({super.key, required this.stocks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = useState<Map<String, double>>({
      for (var stock in stocks) stock.cafeType: 0.0,
    });

    double getTotalWeight() {
      return selection.value.values.fold(0.0, (sum, w) => sum + w);
    }

    void handleSubmit() {
      ref
          .read(assemblyStreamProvider.notifier)
          .createAssemblageFromStock(selection.value);
      Navigator.of(context).pop();
    }

    void handleShuffle() {
      final availableStocks = stocks.where((s) => s.grainWeight > 0).toList();
      if (availableStocks.isEmpty) return;
      final random = <String, double>{};
      double totalWeight = 0.0;
      for (var stock in availableStocks) {
        final rand = (0.3 + 0.7 * (stock.hashCode % 100) / 100);
        random[stock.cafeType] = rand;
        totalWeight += rand;
      }
      final normalized = <String, double>{};
      double finalTotal = 0.0;
      for (var stock in availableStocks) {
        final proportion = random[stock.cafeType]! / totalWeight;
        final amount = (1.0 * proportion).clamp(0.0, stock.grainWeight);

        normalized[stock.cafeType] = double.parse(amount.toStringAsFixed(3));
        finalTotal += normalized[stock.cafeType]!;
      }
      final diff = double.parse((1.0 - finalTotal).toStringAsFixed(3));
      if (diff > 0) {
        for (var stock in availableStocks) {
          final name = stock.cafeType;
          final available = stock.grainWeight - normalized[name]!;
          if (available >= diff) {
            normalized[name] = double.parse(
              (normalized[name]! + diff).toStringAsFixed(3),
            );
            break;
          }
        }
      }
      selection.value = normalized;
    }

    void handleReset() {
      selection.value = {
        for (var stock in stocks) stock.cafeType: 0.0,
      };
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Créer un Assemblage',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  final stock = stocks[index];
                  return AssemblySlider(
                    stock: stock,
                    value: selection.value[stock.cafeType] ?? 0.0,
                    onChanged: (v) {
                      selection.value = {
                        ...selection.value,
                        stock.cafeType: v,
                      };
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total: ${getTotalWeight().toStringAsFixed(3)} kg',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            AssemblyButtons(
              onSubmit: getTotalWeight() >= 1.0 ? handleSubmit : null,
              onShuffle: handleShuffle,
              onReset: handleReset,
            ),
          ],
        ),
      ),
    );
  }
}
