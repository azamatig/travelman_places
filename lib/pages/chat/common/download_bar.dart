import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import '../core/export.dart';
import '../core/styles.dart';

Future<void> showDownloadProgressBar(String imgUrl, {String fileName}) async {
  await checkStoragePermission();
  final progressStream = StreamController<double>();
  BotToast.showCustomLoading(
    toastBuilder: (_) => StreamBuilder<double>(
      stream: progressStream.stream,
      initialData: 0,
      builder: (ctx, snapshot) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: AppTheme.primaryDarkColor,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Downloading ${(snapshot.data * 100).toInt()}%',
              style: TextStyle(color: Theme.of(ctx).buttonColor),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(value: snapshot.data),
          ],
        ),
      ),
    ),
  );
  try {
    // download image and save it
    await ImageDownloader.downloadImage(
      imgUrl,
      destination: AndroidDestinationType.directoryPictures,
    );
    ImageDownloader.callback(onProgressUpdate: (_, progress) {
      progressStream.add(progress.toDouble());
    });
    BotToast.showText(
        text: 'Download Finished', duration: Duration(seconds: 4));
  } catch (e, s) {
    print(e);
    BotToast.showText(text: 'Oops! Failed To Download');
  }
  BotToast.closeAllLoading();
  await progressStream.close();
}
