import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/widget/profils/profile_tab.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerNotifier);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green[200],
            child: Text(
              player?.firstName != null && player?.lastName != null
                  ? '${player?.firstName![0]}${player?.lastName![0]}'
                  : 'UK',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChip('💎 DeeVee', player!.deeVee.toString(), Colors.blue),
              const SizedBox(width: 16),
              _buildChip(
                  '🌟 GoldSeed', player.goldSeed.toString(), Colors.amber),
            ],
          ),
        ),
        const Expanded(
          child: ProfileTab(),
        ),
      ],
    );
  }

  Widget _buildChip(String label, String value, Color color) {
    return Chip(
      backgroundColor: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
