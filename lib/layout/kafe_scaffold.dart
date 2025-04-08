import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/layout/kafe_appbar.dart';
import 'package:kafecraft_exam/layout/kafe_bottom_navigation.dart';
import 'package:kafecraft_exam/provider/bottom_navigation_provider.dart';
import 'package:kafecraft_exam/provider/firebase_auth_provider.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';

class KafeScaffold extends HookConsumerWidget {
  final Widget body;
  KafeScaffold({super.key, required this.body});
  final dynamic _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCredentials = ref.watch(firebaseNotifier);
    final player = ref.read(playerNotifier.notifier);
    final indexNotifier = ref.read(bottomNavigationIndexProvider.notifier);
    void onLoginPressed() {
      if (userCredentials != null) {
        player.logoutFromFirebase();
        indexNotifier.updateIndex(0);
        context.go('/login');
      }
      print("Logout pressed");
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: KafeAppBar(onLogoutPressed: () => onLoginPressed()),
      bottomNavigationBar: const KafeBottomNavigation(),
      body: body,
      backgroundColor: const Color(0xfffe6dbcb),
    );
  }
}
