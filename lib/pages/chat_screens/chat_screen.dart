import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelman/data/old_repo.dart';
import 'package:travelman/models/user.dart';
import 'package:travelman/pages/chat_screens/chat_details.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _repository = Repository();
  List<UserModel> usersList = List<UserModel>();

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      _repository.fetchAllUsers(user).then((updatedList) {
        setState(() {
          usersList = updatedList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              )),
          title: Text(
            'Чат',
            style: GoogleFonts.poppins(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: ChatSearch(usersList: usersList));
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ChatDetailScreen(
                                photoUrl: usersList[index].photoUrl,
                                name: usersList[index].displayName,
                                receiverUid: usersList[index].uid,
                              ))));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(usersList[index].photoUrl),
                  ),
                  title: Text(usersList[index].displayName),
                ),
              ),
            );
          }),
        ));
  }
}

class ChatSearch extends SearchDelegate<String> {
  List<UserModel> usersList;
  ChatSearch({this.usersList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<UserModel> suggestionsList = query.isEmpty
        ? usersList
        : usersList.where((p) => p.displayName.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: ((context, index) => ListTile(
            onTap: () {
              //   showResults(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChatDetailScreen(
                            photoUrl: suggestionsList[index].photoUrl,
                            name: suggestionsList[index].displayName,
                            receiverUid: suggestionsList[index].uid,
                          ))));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(suggestionsList[index].photoUrl),
            ),
            title: Text(suggestionsList[index].displayName),
          )),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
