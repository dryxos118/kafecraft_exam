import 'package:flutter/material.dart';

class SnackbarService {
  final BuildContext context;

  SnackbarService(this.context);

  void showSnackbar({
    required String title,
    required Type type,
  }) {
    final Color backgroundColor;
    final int duration;
    final Icon icon;

    switch (type) {
      case Type.succes:
        backgroundColor = Colors.green;
        duration = 3;
        icon = const Icon(Icons.check);
        break;
      case Type.warning:
        backgroundColor = Colors.yellowAccent;
        duration = 4;
        icon = const Icon(Icons.warning);
        break;
      case Type.danger:
        backgroundColor = Colors.red;
        duration = 5;
        icon = const Icon(Icons.close);
        break;
      default:
        backgroundColor = Colors.blue;
        duration = 5;
        icon = const Icon(Icons.info_outline);
    }

    // Afficher le message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        showCloseIcon: true,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 160,
            right: 20,
            left: 20),
      ),
    );
  }
}

enum Type { succes, warning, danger }
