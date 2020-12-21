import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File> showImageSourceSelectorDialog(BuildContext context) =>
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () async {
              final picked =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              Navigator.of(context)
                  .pop(picked == null ? null : File(picked.path));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.image),
                SizedBox(width: 10),
                Text('Gallery'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final picked =
                  await ImagePicker().getImage(source: ImageSource.camera);
              Navigator.of(context)
                  .pop(picked == null ? null : File(picked.path));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.camera_alt),
                SizedBox(width: 10),
                Text('Camera'),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel'),
        ),
      ),
    );
