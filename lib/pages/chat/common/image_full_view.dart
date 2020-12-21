import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../core/assets.dart';
import 'download_bar.dart';

class ImageFullViewWidget extends StatefulWidget {
  final String imgUrl;
  final bool isLocal;
  final List<String> urls;

  const ImageFullViewWidget(
      {Key key,
      @required this.imgUrl,
      this.urls = const [],
      this.isLocal = false})
      : super(key: key);

  @override
  _ImageFullViewWidgetState createState() => _ImageFullViewWidgetState();
}

class _ImageFullViewWidgetState extends State<ImageFullViewWidget> {
  int selectedIndex;
  List<String> urls;
  bool isLocal;
  @override
  void initState() {
    urls = widget.urls.isEmpty ? [widget.imgUrl] : widget.urls;
    selectedIndex = urls.indexOf(widget.imgUrl);
    isLocal = widget.isLocal ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: PageView.builder(
              itemCount: urls.length,
              controller: PageController(initialPage: selectedIndex ?? 0),
              onPageChanged: (i) async {
                selectedIndex = i;
                setState(() {});
              },
              itemBuilder: (_, i) => PhotoView(
                imageProvider: isLocal
                    ? FileImage(File(urls[i]))
                    : CachedNetworkImageProvider(urls[i]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered,
                loadFailedChild: Image.asset(
                  AssetsHelper.BLURRED_PIC,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 8,
            child: FloatingActionButton(
              heroTag: 'close',
              child: Icon(
                Icons.clear,
                color: theme.accentColor,
              ),
              onPressed: Navigator.of(context).pop,
              mini: true,
              backgroundColor: theme.primaryColor.withOpacity(0.5),
            ),
          ),
          if (!isLocal)
            Positioned(
              top: 28,
              right: 8,
              child: FloatingActionButton(
                heroTag: 'download',
                child: Icon(
                  Icons.file_download,
                  color: theme.accentColor,
                ),
                onPressed: () {
                  showDownloadProgressBar(widget.imgUrl);
                },
                mini: true,
                backgroundColor: theme.primaryColor.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }
}
