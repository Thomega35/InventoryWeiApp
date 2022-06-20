import 'package:flutter/material.dart';

class ChangeNamePopUp {
  String newName = "";
  show(BuildContext context,String question, String name, Function onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(question),
        content:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: name,
              style: Theme.of(context).textTheme.subtitle1,
              onChanged: (value) {
                newName = value;
              },
            ),
          ],
        ),

        actions: <Widget>[
          TextButton(
            child: const Text("Annuler"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Ok"),
            onPressed: () {
              onConfirm(newName);
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}