import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelman/data/location.dart';
import 'package:travelman/utils/colors.dart';
import 'package:travelman/widgets/consts_temp.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'dart:io';
import 'package:geocoder/geocoder.dart';

class UploadStory extends StatefulWidget {
  final String userId;
  final String name;
  final String profileImageUrl;
  final bool isOperator;

  const UploadStory(
      {Key key, this.userId, this.name, this.profileImageUrl, this.isOperator})
      : super(key: key);

  _UploadStory createState() => _UploadStory();
}

class _UploadStory extends State<UploadStory> {
  File file;
  //Strings required to save address
  Address address;
  Map<String, double> currentLocation = Map();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool uploading = false;

  @override
  initState() {
    //variables with location assigned as 0.0
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    initPlatformState(); //method to call location
    super.initState();
  }

  //method to get Location and save into variables

  initPlatformState() async {
    Address first = await getUserLocation();
    if (mounted) {
      setState(() {
        address = first;
      });
    }
  }

  Widget build(BuildContext context) {
    return file == null
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plusCircle,
                        color: kPinBlue,
                        size: 20,
                      ),
                      onPressed: () => {_selectImage(context)}),
                  SizedBox(height: 20),
                  Text(
                    'Сделать Story',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.white70,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: clearImage),
              title: const Text(
                'Post to',
                style: const TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      if (widget.isOperator == true) {
                        _selectWhereToPost(context);
                      } else {
                        postImage();
                      }
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ))
              ],
            ),
            body: ListView(
              children: <Widget>[
                PostForm(
                  imageFile: file,
                  descriptionController: descriptionController,
                  locationController: locationController,
                  loading: uploading,
                  profileImageUrl:
                      'https://image.shutterstock.com/image-vector/user-login-authenticate-icon-human-260nw-1365533969.jpg',
                ),
                Divider(), //scroll view where we will show location to users
                (address == null)
                    ? Container()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Row(
                          children: <Widget>[
                            buildLocationButton(address.featureName),
                            buildLocationButton(address.subLocality),
                            buildLocationButton(address.locality),
                            buildLocationButton(address.subAdminArea),
                            buildLocationButton(address.adminArea),
                            buildLocationButton(address.countryName),
                          ],
                        ),
                      ),
                (address == null) ? Container() : Divider(),
              ],
            ),
          );
  }

  //method to build buttons with location.
  buildLocationButton(String locationName) {
    if (locationName != null ?? locationName.isNotEmpty) {
      return InkWell(
        onTap: () {
          locationController.text = locationName;
        },
        child: Center(
          child: Container(
            //width: 100.0,
            height: 30.0,
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            margin: EdgeInsets.only(right: 3.0, left: 3.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                locationName,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog<Null>(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final _picker = ImagePicker();
        return SimpleDialog(
          title: const Text('Создать post'),
          children: <Widget>[
            SimpleDialogOption(
                child: const Text('Фото'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  PickedFile imageFile =
                      await _picker.getImage(source: ImageSource.camera);
                  setState(() {
                    file = File(imageFile.path);
                  });
                }),
            SimpleDialogOption(
                child: const Text('Выбрать из галереи'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  var pick = ImagePicker();
                  PickedFile imageFile = await pick.getImage(
                      source: ImageSource.gallery,
                      maxWidth: 1920,
                      maxHeight: 1200,
                      imageQuality: 80);
                  setState(() {
                    file = File(imageFile.path);
                  });
                }),
            SimpleDialogOption(
              child: const Text("Отмена"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _selectWhereToPost(context) {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Отправиать post'),
          children: <Widget>[
            SimpleDialogOption(
                child: const Text('Турист лента'),
                onPressed: () async {
                  postImage();
                  Navigator.of(context).pop();
                }),
            SimpleDialogOption(
              child: const Text("Отмена"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  void postImage() {
    setState(() {
      uploading = true;
    });
    uploadImage(file).then((String data) {
      postToFireStore(
        mediaUrl: data,
        description: descriptionController.text,
      );
    }).then((_) {
      setState(() {
        file = null;
        uploading = false;
      });
    });
  }
}

class PostForm extends StatelessWidget {
  final imageFile;
  final TextEditingController descriptionController;
  final TextEditingController locationController;
  final String profileImageUrl;
  final bool loading;
  PostForm({
    this.imageFile,
    this.descriptionController,
    this.loading,
    this.locationController,
    this.profileImageUrl,
  });

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? LinearProgressIndicator()
            : Padding(padding: EdgeInsets.only(top: 0.0)),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.shutterstock.com/image-vector/user-login-authenticate-icon-human-260nw-1365533969.jpg'),
            ),
            Container(
              width: 250.0,
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                    hintText: "Описание здесь...", border: InputBorder.none),
              ),
            ),
            Container(
              height: 45.0,
              width: 45.0,
              child: AspectRatio(
                aspectRatio: 487 / 451,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    alignment: FractionalOffset.topCenter,
                    image: FileImage(imageFile),
                  )),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.pin_drop),
          title: Container(
            width: 250.0,
            child: TextField(
              controller: locationController,
              decoration: InputDecoration(
                  hintText: "Где было сфотографированно?",
                  border: InputBorder.none),
            ),
          ),
        )
      ],
    );
  }
}

Future<String> uploadImage(var imageFile) async {
  var uuid = Uuid().v1();
  StorageReference ref = FirebaseStorage.instance.ref().child("post_$uuid.jpg");
  StorageUploadTask uploadTask = ref.putFile(imageFile);

  String downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  return downloadUrl;
}

void postToFireStore({
  BuildContext context,
  String mediaUrl,
  String description,
}) async {
  storiesRef.add({
    "date": DateTime.now(),
    "file": FieldValue.arrayUnion([
      {
        "fileTitle": {'en': description},
        "fileType": 'image',
        'url': {'en': mediaUrl}
      },
    ]),
    "previewImage": mediaUrl,
    "previewTitle": {'en': ''},
  });
}
