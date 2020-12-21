import 'package:flutter/material.dart';

Future<void> showDeleteAlertDialog(
    BuildContext context, VoidCallback onDelete) async {
      print('show Daialog');
  await showDialog(
    context: context,
    child: AlertDialog(
      title: Text('Are you sure you want to delete?'),
      actions: <Widget>[
        RaisedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            }),
        SizedBox(width: 20),
        RaisedButton(
          child: Text('Delete'),
          onPressed: onDelete,
        ),
      ],
    ),
  );
}
