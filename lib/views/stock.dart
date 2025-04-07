import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Stock extends HookConsumerWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock'),
      ),
      body: const Center(
        child: Text(
          'stock.dart',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
