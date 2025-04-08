import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kafecraft_exam/provider/bottom_navigation_provider.dart';

class KafeBottomNavigation extends HookConsumerWidget {
  const KafeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationIndexProvider);
    final indexNotifier = ref.read(bottomNavigationIndexProvider.notifier);

    void onItemTapped(int index) {
      indexNotifier.updateIndex(index); // Mise à jour de l'index
      switch (index) {
        case 0:
          context.go('/farme');
          break;
        case 1:
          context.go('/stock');
          break;
        case 2:
          context.go('/competition');
          break;
        case 3:
          context.go('/profile');
          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.brown.shade800,
      unselectedItemColor: Colors.grey,
      backgroundColor: const Color.fromARGB(255, 229, 211, 184),
      currentIndex: currentIndex,
      onTap: onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture),
          label: 'Farm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          label: 'Stock',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Competition',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
