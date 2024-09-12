import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Exit App"),
        content: Text("Are you sure you want to exit the app?"),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text("Exit"),
            onPressed: () {
              SystemNavigator.pop(); // Exit the app
            },
          ),
        ],
      );
    },
  );
}