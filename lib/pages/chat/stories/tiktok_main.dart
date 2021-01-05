import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelman/pages/chat/stories/tiktok_stuff/add_video_button.dart';
import 'package:travelman/pages/chat/stories/tiktok_stuff/tiktok_message.dart';
import 'package:travelman/pages/chat/stories/tiktok_stuff/tiktok_profile.dart';
import 'package:travelman/pages/chat/stories/tiktok_stuff/tiktok_search.dart';
import 'package:travelman/pages/chat/stories/tiktok_video.dart';

class TiktokHome extends StatefulWidget {
  @override
  _TiktokHomeState createState() => _TiktokHomeState();
}

class _TiktokHomeState extends State<TiktokHome> {
  static const double CreateButtonWidth = 38.0;

  List pageOptions = [
    VideoPage(),
    SearchPage(),
    TikTokAddVIdeoPage(),
    MessagePage(),
    ProfilePage(FirebaseAuth.instance.currentUser.uid),
  ];

  int pageIdx = 0;

  customIcon() {
    return Container(
      width: 45.0,
      height: 30.0,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 211, 234),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: customIcon(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
            ),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pageOptions[pageIdx],
    );
  }
}
