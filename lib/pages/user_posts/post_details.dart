import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/models/user.dart';
import 'package:travelman/pages/user_posts/post_comments.dart';
import 'package:travelman/widgets/consts_temp.dart';

class PostDetails extends StatefulWidget {
  final String userId;
  final String desc;
  final String imgUrl;
  final DocumentReference documentReference;
  final UserModel currentUser;
  final DocumentSnapshot documentSnapshot;
  final UserModel user, currentuser;

  PostDetails(
      {this.userId,
      this.desc,
      this.imgUrl,
      this.documentReference,
      this.currentUser,
      this.documentSnapshot,
      this.user,
      this.currentuser});

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  FutureBuilder _postDetails() {
    return FutureBuilder(
        future: usersRef.doc(widget.userId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          UserModel user = UserModel.fromFirestore(snapshot.data);
          return SingleChildScrollView(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 779,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(widget.imgUrl),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 15,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: user.photoUrl,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      user.displayName,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Container(
                                    child: Text(
                                      widget.desc,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _postDetails(),
          Spacer(),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            height: 65,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                        width: 40,
                        height: 35,
                        child: Icon(FontAwesomeIcons.heart)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                        width: 40,
                        height: 35,
                        child: Icon(FontAwesomeIcons.shareAlt)),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 20),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: 75,
                      height: 35,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CommentsScreen(
                                        userId: widget.userId,
                                        documentReference:
                                            widget.documentReference,
                                        user: widget.currentUser,
                                      )));
                        },
                        icon: Icon(FontAwesomeIcons.commentAlt),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
