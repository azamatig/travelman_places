import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../group_editor/controller.dart';

class GroupImage extends StatelessWidget {
  final GroupEditorController editor;

  const GroupImage({Key key, this.editor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Badge(
      showBadge: editor != null,
      badgeContent: GestureDetector(
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        onTap: editor != null ? editor.pickImage : null,
      ),
      position: BadgePosition(bottom: 1, start: 1),
      child: Observer(
        builder: (_) => SizedBox(
          height: 100,
          width: 100,
          child: editor?.isImageUploading == true
              ? CircularProgressIndicator().padding(all: 2)
              : editor?.imageFileToUpload == null
                  ? CachedNetworkImage(
                      imageUrl: editor.photoUrl ?? '',
                      placeholder: (_, __) =>
                          CircularProgressIndicator().padding(all: 2),
                      errorWidget: (_, __, ___) => Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 50,
                      ),
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      editor.imageFileToUpload,
                      fit: BoxFit.fill,
                    ),
        ).backgroundColor(theme.primaryColorDark).clipOval(),
      ),
    );
  }
}
