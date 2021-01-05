import "package:flutter/material.dart";
import 'package:travelman/pages/chat/stories/tiktok_stuff/add_video_page.dart';
import 'package:travelman/pages/chat/stories/tiktok_stuff/globals.dart';
import 'package:travelman/utils/next_screen.dart';

class TikTokAddVIdeoPage extends StatefulWidget {
  @override
  _TikTokAddVIdeoPageState createState() => _TikTokAddVIdeoPageState();
}

class _TikTokAddVIdeoPageState extends State<TikTokAddVIdeoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InkWell(
          onTap: () => nextScreen(context, AddVideoPage()),
          child: Container(
            width: 190,
            height: 80,
            decoration: BoxDecoration(color: Colors.red),
            child: Center(
              child: Text(
                "Add Video",
                style: latoStyle(30, Colors.black, FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
