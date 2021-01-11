import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:travelman/blocs/sign_in_bloc.dart';
import 'package:travelman/data/old_provider.dart';
import 'package:travelman/data/old_repo.dart';
import 'package:travelman/models/user.dart';
import 'package:travelman/pages/stories/story_main.dart';
import 'package:travelman/pages/user_posts/post_comments.dart';
import 'package:travelman/pages/user_posts/post_details.dart';
import 'package:travelman/pages/user_posts/post_likes.dart';
import 'package:provider/provider.dart';
import 'package:travelman/pages/user_posts/user_post_uploader.dart';
import 'package:travelman/utils/next_screen.dart';

class UserPostSection extends StatefulWidget {
  UserPostSection({
    Key key,
  }) : super(key: key);

  @override
  _UserPostSectionState createState() => _UserPostSectionState();
}

class _UserPostSectionState extends State<UserPostSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pb = context.watch<SignInBloc>();
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      padding: EdgeInsets.only(top: 5.0),
      child: FeedScreen(
        userId: pb.uid,
        name: pb.name,
        profileImgUrl: pb.imageUrl,
      ),
    );
  }
}

class FeedScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String profileImgUrl;

  FeedScreen({Key key, this.userId, this.name, this.profileImgUrl})
      : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final db = FirebaseFirestore.instance;
  var _repository = Repository();
  UserModel currentUser, user, followingUser;
  List<String> followingUIDs = List<String>();
  List<UserModel> usersList = List<UserModel>();
  bool _isLiked = false;

  Container buildItem(DocumentSnapshot doc) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 5, top: 15),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: ClipOval(
                        child: Image.network(
                          doc.data()['authorPhotoUrl'] ?? '-',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                        doc.data()['authorName'] ?? '-',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        GestureDetector(
                          onDoubleTap: () {},
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PostDetails(
                                          userId: doc.data()['authorId'],
                                          desc: doc.data()['content'],
                                          imgUrl: doc.data()['imgUrl'],
                                          documentReference: doc.reference,
                                          currentUser: currentUser,
                                        )));
                          },
                          child: Container(
                            height: 350,
                            width: 400,
                            child: Image.network(
                              doc.data()['imgUrl'] ?? '-',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 20,
                          child: Text(
                            doc.data()['location'] ?? '-',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    FutureBuilder(
                      future: _repository.fetchPostLikes(doc.reference),
                      builder: ((context,
                          AsyncSnapshot<List<DocumentSnapshot>> likesSnapshot) {
                        if (likesSnapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LikesScreen(
                                            user: currentUser,
                                            documentReference: doc.reference,
                                          ))));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: likesSnapshot.data.length > 1
                                  ? Text(
                                      "Нравится ${likesSnapshot.data[0].data()['ownerName']} и ${(likesSnapshot.data.length - 1).toString()} другие",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(likesSnapshot.data.length == 1
                                      ? "Нравится ${likesSnapshot.data[0].data()['ownerName']}"
                                      : "0 Нравится"),
                            ),
                          );
                        } else {
                          return Center(child: SizedBox());
                        }
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ReadMoreText(
                        doc.data()['content'] ?? '',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                        trimLines: 2,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Читать всё',
                        trimExpandedText: 'меньше',
                      ),
                    ),
                    commentWidget(doc.reference),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                          child: GestureDetector(
                            onTap: () {
                              if (!_isLiked) {
                                setState(() {
                                  _isLiked = true;
                                });
                                FirebaseProvider.postLike(
                                    doc.reference,
                                    widget.name,
                                    widget.userId,
                                    widget.profileImgUrl);
                              } else {
                                setState(() {
                                  _isLiked = false;
                                });
                                //saveLikeValue(_isLiked);
                                FirebaseProvider.postUnlike(
                                    doc.reference, currentUser, widget.userId);
                              }
                            },
                            child: _isLiked
                                ? Container(
                                    width: 40,
                                    height: 35,
                                    child: Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.red,
                                      size: 20,
                                    ))
                                : Container(
                                    width: 40,
                                    height: 35,
                                    child: Icon(
                                      FontAwesomeIcons.heart,
                                      color: Colors.black,
                                      size: 20,
                                    )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Container(
                              width: 40,
                              height: 35,
                              child: IconButton(
                                icon: Icon(FontAwesomeIcons.shareAlt, size: 20),
                                onPressed: () async {
                                  await FlutterShareMe().shareToWhatsApp(
                                      msg: 'ссылка на приложение');
                                },
                              )),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0, right: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CommentsScreen(
                                            userId: widget.userId,
                                            documentReference: doc.reference,
                                            user: currentUser,
                                          )));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: 50,
                              height: 35,
                              child: Icon(
                                FontAwesomeIcons.commentAlt,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget commentWidget(DocumentReference reference) {
    return FutureBuilder(
      future: _repository.fetchPostComments(reference),
      builder: ((context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 5),
            child: GestureDetector(
              child: Text(
                'Просмотреть ${snapshot.data.length} комментариев',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CommentsScreen(
                              userId: widget.userId,
                              documentReference: reference,
                              user: currentUser,
                            ))));
              },
            ),
          );
        } else {
          return Center(child: SizedBox());
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              StoryWidget(
                userId: widget.userId,
                profileImgUrl: widget.profileImgUrl,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: db.collection('posts').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.docs
                            .map((doc) => buildItem(doc))
                            .toList(),
                      );
                    }
                    return SizedBox();
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
