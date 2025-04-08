import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/firebase_options.dart';
import 'package:kafecraft_exam/provider/firebase_auth_provider.dart';
import 'package:kafecraft_exam/router/router.dart';
import 'package:kafecraft_exam/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() => ref.read(firebaseNotifier.notifier).initialize());

    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Quiz Exam',
        // theme
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: MaterialTheme.lightMediumContrastScheme()),
        themeMode: ThemeMode.light,
        // Locale
        locale: const Locale('fr', 'fr'),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
