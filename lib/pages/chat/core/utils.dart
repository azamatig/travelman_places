import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path_helper;
import 'package:url_launcher/url_launcher.dart';

void showSnackBarMsg(ScaffoldState scaffoldState, String message) {
  scaffoldState.showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: Theme.of(scaffoldState.context)
            .textTheme
            .subtitle2
            .copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Future<String> uploadFile(File file, String childName,
    {String fileName = ''}) async {
  if (Platform.isAndroid) {
    await checkStoragePermission();
  }
  try {
    final fileNameWithExtention = (fileName.isEmpty
            ? DateTime.now().millisecondsSinceEpoch.toString()
            : fileName) +
        path_helper.extension(file.path);
    final task = FirebaseStorage.instance
        .ref()
        .child(childName)
        .child(fileNameWithExtention)
        .putFile(file);
    final snap = await task.onComplete;

    return await snap.ref.getDownloadURL();
  } catch (e, s) {
    print('Excpetion $e');

    return null;
  }
}

Future<bool> checkStoragePermission() async {
  if (kIsWeb || !Platform.isAndroid) return true;
  if (!await Permission.storage.isGranted) {
    return (await Permission.storage.request()).isGranted;
  }
  return true;
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}
