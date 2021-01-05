import 'package:flutter/material.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';

Future<void> showDeleteAlertDialog(
    BuildContext context, VoidCallback onDelete) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Вы уверены что хотите удалить?'),
      actions: <Widget>[
        RaisedButton(
            child: Text('Отмена'),
            onPressed: () {
              Navigator.pop(context);
            }),
        SizedBox(width: 20),
        RaisedButton(
          child: Text(t.Feed.delete),
          onPressed: onDelete,
        ),
      ],
    ),
  );
}
