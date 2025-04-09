import 'package:flutter/material.dart';
import 'package:kafecraft_exam/model/stock.dart';

class AssemblySlider extends StatelessWidget {
  final Stock stock;
  final double value;
  final ValueChanged<double> onChanged;

  const AssemblySlider({
    super.key,
    required this.stock,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0.0, stock.grainWeight);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '${stock.cafeType} (${stock.grainWeight.toStringAsFixed(3)} kg)'),
          Slider(
            value: clampedValue,
            min: 0,
            max: stock.grainWeight,
            divisions: 100,
            label: '${clampedValue.toStringAsFixed(3)} kg',
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
