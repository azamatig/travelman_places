import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:travelman/pages/chat/stories/stories_main.dart';
import '../../../export.dart';
import 'user_avatar.dart';

class AddPostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUserAvatar =
        Modular.get<AuthController>().currentUser.photoUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          StoryWidget(),
          GestureDetector(
            onTap: FeedsModule.toCreatPost,
            child: Row(
              children: <Widget>[
                UserAvatar(
                  photo: currentUserAvatar,
                  radius: 40,
                  showBadge: false,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Text(t.Feed.what_on_mind),
                          Spacer(),
                          Icon(Icons.send)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
