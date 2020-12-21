import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';
import '../../export.dart';
import 'controller.dart';
import 'widgets/group_img.dart';

class GroupEditor extends WidgetModule {
  final Group toEditGroup;
  GroupEditor({this.toEditGroup});

  @override
  List<Bind> get binds => [Bind((_) => GroupEditorController(toEditGroup))];

  @override
  Widget get view => _GroupEditor();
}

class _GroupEditor extends StatefulWidget {
  @override
  _GroupEditorState createState() => _GroupEditorState();
}

class _GroupEditorState
    extends ModularState<_GroupEditor, GroupEditorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(controller.isToEdit ? t.Groups.edit : t.Groups.create_group),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          GroupImage(
            editor: controller,
          ).padding(vertical: 20),
          CustomTextForm(
            label: t.Groups.group_name,
            borderRadius: 10,
            controller: controller.nameController,
            maxLength: 20,
          ),
          SizedBox(height: 20),
          Observer(
            builder: (_) => CustomButton(
              t.Groups.save,
              isLoading: controller.isImageUploading,
              onTap: controller.onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
