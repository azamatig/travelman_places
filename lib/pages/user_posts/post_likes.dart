import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/data/old_repo.dart';
import 'package:travelman/models/user.dart';

class LikesScreen extends StatefulWidget {
  final DocumentReference documentReference;
  final UserModel user;
  LikesScreen({this.documentReference, this.user});

  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  var _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Нравится',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: _repository.fetchPostLikes(widget.documentReference),
        builder: ((context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0, top: 16.0),
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {},
                      child: Text(
                        snapshot.data[index].data()['ownerName'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[index].data()['ownerPhotoUrl']),
                        radius: 30.0,
                      ),
                    ),
                  ),
                );
              }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('No Likes found'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
