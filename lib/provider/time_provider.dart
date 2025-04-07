import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timeUpdatesProvider = StreamProvider.autoDispose<void>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (_) => null);
});
