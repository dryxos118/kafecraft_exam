import 'package:flutter/material.dart';

class AssemblyButtons extends StatelessWidget {
  final VoidCallback? onSubmit;
  final VoidCallback onShuffle;
  final VoidCallback onReset;

  const AssemblyButtons({
    super.key,
    required this.onSubmit,
    required this.onShuffle,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.local_cafe),
            label: const Text("Créer"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[200],
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onShuffle,
          icon: const Icon(Icons.shuffle, color: Colors.orange),
          tooltip: 'Mélange aléatoire',
        ),
        IconButton(
          onPressed: onReset,
          icon: const Icon(Icons.restart_alt, color: Colors.red),
          tooltip: 'Réinitialiser',
        ),
      ],
    );
  }
}
