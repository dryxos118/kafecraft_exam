import 'package:flutter/material.dart';

class KafeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onLogoutPressed;

  const KafeAppBar({super.key, required this.onLogoutPressed});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
      child: AppBar(
        backgroundColor: Colors.brown.shade600,
        elevation: 10.0,
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '☕ KafeCraft',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: onLogoutPressed,
            icon: const Icon(Icons.logout),
            color: Colors.white,
            tooltip: 'Se déconnecter',
          ),
        ],
      ),
    );
  }
}
