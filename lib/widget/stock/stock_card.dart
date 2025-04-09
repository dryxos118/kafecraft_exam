import 'package:flutter/material.dart';
import 'package:kafecraft_exam/model/cafe_type.dart';
import 'package:kafecraft_exam/model/gato.dart';
import 'package:kafecraft_exam/model/stock.dart';
import 'package:kafecraft_exam/data/cafe_data.dart';
import 'package:kafecraft_exam/service/snackbar_service.dart';
import 'package:kafecraft_exam/widget/stock/gato_stat.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  CafeType? getCafeType(String name) {
    return cafeTypes.firstWhere(
      (cafe) => cafe.name == name,
      orElse: () => CafeType(
        name: 'Inconnu',
        avatar: '❓',
        growTime: const Duration(),
        costDeeVee: 0,
        fruitWeight: 0.0,
        gato: Gato(gout: 0, amertume: 0, teneur: 0, odorat: 0),
      ),
    );
  }

  void harvest(BuildContext context) {
    SnackbarService(context)
        .showSnackbar(title: "Assemblage effectuée !", type: Type.succes);
  }

  @override
  Widget build(BuildContext context) {
    final cafeType = getCafeType(stock.cafeType);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.green.shade100,
                  child: Text(
                    cafeType!.avatar,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  cafeType.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  'Sec: ${stock.grainWeight.toStringAsFixed(3)} Kg',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GatoStat(label: "Goût", value: cafeType.gato.gout),
                GatoStat(label: "Amertume", value: cafeType.gato.amertume),
                GatoStat(label: "Teneur", value: cafeType.gato.teneur),
                GatoStat(label: "Odorat", value: cafeType.gato.odorat),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
