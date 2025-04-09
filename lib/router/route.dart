import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kafecraft_exam/layout/kafe_scaffold.dart';
import 'package:kafecraft_exam/views/competition.dart';
import 'package:kafecraft_exam/views/farme.dart';
import 'package:kafecraft_exam/views/field_page.dart';
import 'package:kafecraft_exam/views/login.dart';
import 'package:kafecraft_exam/views/profile.dart';
import 'package:kafecraft_exam/views/register.dart';
import 'package:kafecraft_exam/views/stock.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
      path: "/login",
      name: "Login",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(context, state, const Login());
      }),
  GoRoute(
      path: "/register",
      name: "Register",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(context, state, const Register());
      }),
  GoRoute(
    path: "/farme",
    name: "Farme",
    pageBuilder: (context, state) {
      return _buildFadeTransitionPage(
          context, state, KafeScaffold(body: const Farme()));
    },
  ),
  GoRoute(
    path: "/farme/detail",
    name: "FieldDetail",
    pageBuilder: (context, state) {
      return _buildFadeTransitionPage(
          context, state, KafeScaffold(body: const FieldPage()));
    },
  ),
  GoRoute(
      path: "/stock",
      name: "Stock",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(
            context, state, KafeScaffold(body: const Stock()));
      }),
  GoRoute(
      path: "/competition",
      name: "Competition",
      pageBuilder: (context, state) {
        return _buildFadeTransitionPage(
            context, state, KafeScaffold(body: const Competition()));
      }),
  GoRoute(
    path: "/profile",
    name: "Profile",
    pageBuilder: (context, state) {
      return _buildFadeTransitionPage(
          context, state, KafeScaffold(body: const Profile()));
    },
  )
];

Page _buildFadeTransitionPage(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
