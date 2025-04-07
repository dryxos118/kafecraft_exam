import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Competition extends HookConsumerWidget {
  const Competition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Competition'),
      ),
      body: const Center(
        child: Text(
          'competition.dart',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
