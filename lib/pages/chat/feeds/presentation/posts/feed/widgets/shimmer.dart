import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatelessWidget {
  final loadingAnimationBackground = Colors.black12;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 210,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(),
              title: Container(
                height: 30,
                color: loadingAnimationBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                width: double.infinity,
                height: 80,
                color: loadingAnimationBackground,
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.favorite_border), onPressed: () => null),
                Spacer(),
                IconButton(icon: Icon(Icons.mode_comment), onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
