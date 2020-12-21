import 'package:flutter/material.dart';
import '../../export.dart';

class ImageCard extends StatelessWidget {
  final String url;
  final VoidCallback onTap;

  const ImageCard({Key key, @required this.url, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: url,
            child: Container(
              color: Colors.black,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CustomNetworkImage(
                  url: url,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
