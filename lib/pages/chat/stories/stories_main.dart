import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/pages/chat/stories/upload_story.dart';
import 'package:travelman/utils/colors.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';

class StoryWidget extends StatefulWidget {
  final String userId;
  final String profileImgUrl;

  const StoryWidget({Key key, this.userId, this.profileImgUrl})
      : super(key: key);
  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final String collectionDbName = 'instagram_stories_db';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plusCircle,
                        color: kPinBlue,
                        size: 30,
                      ),
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => UploadStory(
                                          userId: widget.userId,
                                          profileImageUrl: widget.profileImgUrl,
                                        )))
                          }),
                  Text(
                    'Stories',
                    style: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  )
                ],
              )),
              Expanded(
                child: FlutterInstagramStories(
                  collectionDbName: collectionDbName,
                  showTitleOnIcon: false,
                  iconTextStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                  iconImageBorderRadius: BorderRadius.circular(50.0),
                  iconBoxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    color: Color(0xFFffffff),
                  ),
                  iconWidth: 50.0,
                  iconHeight: 50.0,
                  //how long story lasts in seconds
                  imageStoryDuration: 7,
                  progressPosition: ProgressPosition.top,
                  repeat: true,
                  inline: false,
                  languageCode: 'en',
                  backgroundColorBetweenStories: Colors.black,
                  closeButtonIcon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28.0,
                  ),
                  lastIconHighlight: true,
                  lastIconHighlightColor: kPinBlue,
                  lastIconHighlightRadius: const Radius.circular(50.0),
                  closeButtonBackgroundColor: Color(0x11000000),
                  sortingOrderDesc: true,
                  captionMargin: EdgeInsets.only(
                    bottom: 50,
                  ),
                  captionPadding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
