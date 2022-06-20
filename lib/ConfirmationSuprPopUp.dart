import 'package:flutter/material.dart';

class ConfirmationSuprPopUp {
  show(BuildContext context, String name, Function onConfirm) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Suppression"),
          content: Text(name),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Oui"),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
  }
}