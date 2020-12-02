import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image/image.dart' as Im;
import 'package:travelman/data/location.dart';
import 'package:travelman/data/old_repo.dart';
import 'package:travelman/pages/home.dart';

class Uploader extends StatefulWidget {
  final String profileImageUrl;

  const Uploader({Key key, this.profileImageUrl}) : super(key: key);

  _Uploader createState() => _Uploader();
}

class _Uploader extends State<Uploader> {
  File file;
  //Strings required to save address
  Address address;
  String userPhoto;
  Map<String, double> currentLocation = Map();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final _repository = Repository();

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
    String photoUrl =
        await _repository.getCurrentUser().then((value) => value.photoURL);
    Address first = await getUserLocation();
    if (mounted) {
      setState(() {
        address = first;
        userPhoto = photoUrl;
      });
    }
  }

  Widget build(BuildContext context) {
    return file == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.plusCircle,
                    color: Colors.blueAccent,
                    size: 40,
                  ),
                  onPressed: () => {_selectImage(context)}),
              SizedBox(height: 20),
              Text(
                'Сделать новый Post',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
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
                      postImage();
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
                  userPhoto: userPhoto,
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

  void clearImage() {
    setState(() {
      file = null;
    });
  }

  void compressImage() async {
    print('starting compression');
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(file.readAsBytesSync());
    Im.copyResize(image);

    var newim2 = new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));

    setState(() {
      file = newim2;
    });
    print('done');
  }

  void postImage() {
    setState(() {
      uploading = true;
    });
    _repository.getCurrentUser().then((currentUser) {
      if (currentUser != null) {
        compressImage();
        _repository.retrieveUserDetails(currentUser).then((user) {
          _repository.uploadImageToStorage(file).then((url) {
            _repository
                .addPostToDb(user, url, descriptionController.text,
                    locationController.text)
                .then((value) {
              print("Post added to db");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => HomePage())));
            }).catchError((e) => print("Error adding current post to db : $e"));
          }).catchError((e) {
            print("Error uploading image to storage : $e");
          });
        });
      } else {
        print("Current User is null");
      }
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
  final String userPhoto;
  final bool loading;
  PostForm({
    this.imageFile,
    this.descriptionController,
    this.loading,
    this.locationController,
    this.userPhoto,
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
              backgroundImage: NetworkImage(userPhoto),
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
