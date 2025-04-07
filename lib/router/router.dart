import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/firebase_auth_provider.dart';
import 'package:kafecraft_exam/router/route.dart';

final GoRouter router = GoRouter(
  routes: appRoutes,
  initialLocation: "/farme",
  redirect: (context, state) {
    final container = ProviderScope.containerOf(context);
    final isSignedIn = container.read(firebaseNotifier);

    if (isSignedIn == null) {
      if (state.fullPath == "/login" || state.fullPath == "/register") {
        return null;
      }
      print("login");
      return '/login';
    }
    return null;
  },
);
