import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as Im;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travelman/data/old_repo.dart';
import 'package:travelman/models/message.dart';

class ChatDetailScreen extends StatefulWidget {
  final String photoUrl;
  final String name;
  final String receiverUid;

  ChatDetailScreen({this.photoUrl, this.name, this.receiverUid});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  var _formKey = GlobalKey<FormState>();
  String _senderuid;
  TextEditingController _messageController = TextEditingController();
  final _repository = Repository();
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  StreamSubscription<DocumentSnapshot> subscription;
  File imageFile;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      setState(() {
        _senderuid = user.uid;
      });
      _repository.fetchUserDetailsById(_senderuid).then((user) {
        setState(() {
          senderPhotoUrl = user.photoUrl;
          senderName = user.displayName;
        });
      });
      _repository.fetchUserDetailsById(widget.receiverUid).then((user) {
        setState(() {
          receiverPhotoUrl = user.photoUrl;
          receiverName = user.displayName;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xfff8faf8),
          elevation: 1,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              )),
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.photoUrl),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: _senderuid == null
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    ChatMessagesListWidget(),
                    chatInputWidget(),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
        ));
  }

  Widget chatInputWidget() {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        validator: (String input) {
          if (input.isEmpty) {
            return "Please enter message";
          }
          return null;
        },
        controller: _messageController,
        decoration: InputDecoration(
            hintText: "Введите сообщение...",
            labelText: "Сообщения",
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.gradient),
                    color: Colors.black,
                    onPressed: () {
                      pickImage(source: 'Gallery');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowAltCircleRight,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          sendMessage();
                        }
                      }),
                ),
              ],
            ),
            prefixIcon: IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                pickImage(source: 'Camera');
              },
              color: Colors.black,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(40.0))),
        onFieldSubmitted: (value) {
          _messageController.text = value;
        },
      ),
    );
  }

  Future<void> pickImage({String source}) async {
    var pick = ImagePicker();
    PickedFile selectedImage = await pick.getImage(
        source: source == 'Gallery' ? ImageSource.gallery : ImageSource.camera);

    setState(() {
      imageFile = File(selectedImage.path);
    });
    compressImage();
    _repository.uploadImageToStorage(imageFile).then((url) {
      _repository.uploadImageMsgToDb(url, widget.receiverUid, _senderuid);
    });
    return;
  }

  void compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
    Im.copyResize(image);

    var newim2 = new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));

    setState(() {
      imageFile = newim2;
    });
  }

  void sendMessage() {
    var text = _messageController.text;
    Message _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    _repository.addMessageToDb(_message, widget.receiverUid).then((v) {
      _messageController.text = "";
    });
  }

  // ignore: non_constant_identifier_names
  Widget ChatMessagesListWidget() {
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(_senderuid)
            .collection(widget.receiverUid)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //listItem = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: snapshot['senderUid'] == _senderuid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              snapshot['senderUid'] == _senderuid
                  ? senderLayout(snapshot)
                  : receiverLayout(snapshot)
            ],
          ),
        )
      ],
    );
  }

  Widget senderLayout(DocumentSnapshot snapshot) {
    return snapshot['type'] == 'text'
        ? Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(22.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(snapshot['message'],
                    style: TextStyle(color: Colors.black, fontSize: 16.0))),
          )
        : FadeInImage(
            fit: BoxFit.cover,
            image: NetworkImage(snapshot['photoUrl']),
            placeholder: AssetImage('assets/images/ph.png'),
            width: 250.0,
            height: 300.0,
          );
  }

  Widget receiverLayout(DocumentSnapshot snapshot) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: snapshot['type'] == 'text'
            ? Text(snapshot['message'],
                style: TextStyle(color: Colors.black, fontSize: 16.0))
            : FadeInImage(
                fit: BoxFit.cover,
                image: NetworkImage(snapshot['photoUrl']),
                placeholder: AssetImage('assets/images/ph.png'),
                width: 200.0,
                height: 200.0,
              ),
      ),
    );
  }
}
