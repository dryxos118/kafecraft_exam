import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0);

  void updateIndex(int index) => state = index;
}

final bottomNavigationIndexProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>(
  (ref) => BottomNavigationNotifier(),
);
