import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../export.dart';
import 'controller.dart';

class AddWallpaperScreen extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((_) => AddWallController())];

  @override
  Widget get view => _AddWallpaper();
}

class _AddWallpaper extends StatefulWidget {
  @override
  _AddWallpaperState createState() => _AddWallpaperState();
}

class _AddWallpaperState
    extends ModularState<_AddWallpaper, AddWallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.Wallpapers.add_wallpaper),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          CustomTextForm(
            label: t.Wallpapers.wall_name,
            borderRadius: 10,
            controller: controller.nameController,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Observer(
                builder: (_) {
                  return controller.uploadImgListener.when<Widget>(
                    initial: () => IconButton(
                        icon: Icon(Icons.add, size: 50),
                        onPressed: controller.pickWallpaper),
                    wallpaperPicked: (path) => Stack(
                      children: <Widget>[
                        Center(
                          child: Image.file(
                            File(path),
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                        Align(
                          alignment: Alignment(1.3, -1.1),
                          child: MaterialButton(
                            splashColor: Colors.red,
                            color: Theme.of(context).primaryColor,
                            shape: CircleBorder(),
                            child: Icon(Icons.close),
                            onPressed: () {
                              controller.uploadImgListener =
                                  UploadState.initial();
                            },
                          ),
                        ),
                      ],
                    ),
                    uploading: () => Center(child: CircularProgressIndicator()),
                    success: (e) {
                      Future.delayed(Duration(seconds: 1)).then((v) {
                        Navigator.pop(context);
                      });
                      return Container();
                    },
                    failed: () => GestureDetector(
                      onTap: controller.pickWallpaper,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.warning,
                            size: 40,
                          ),
                          SizedBox(height: 4),
                          Text(t.Wallpapers.failed_to_upload)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.cloud_upload),
            color: Theme.of(context).primaryColor,
            label: Text(t.Wallpapers.upload),
            onPressed: controller.uploadWallpaper,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
