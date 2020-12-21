import 'package:flutter/material.dart';

class ImportPhotoBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            'Profile Photo',
            style: theme.textTheme.headline6,
          ),
          SizedBox(height: 10),
          Expanded(
            child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: (index) {
                switch (index) {
                  case 0:
                    break;
                  case 1:
                    break;
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.photo_album),
                    title: Text(
                      'Gallery',
                      style: theme.textTheme.headline6,
                    )),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt),
                  title: Text(
                    'Camera',
                    style: theme.textTheme.headline6,
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
