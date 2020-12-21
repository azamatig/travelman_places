import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import '../../../export.dart';

class CommentInput extends StatefulWidget {
  final Function(String) onSubmit;
  final EdgeInsets contentPadding;
  final String initContent;
  final bool showAvatar;

  CommentInput(
      {Key key,
      this.onSubmit,
      this.contentPadding,
      this.initContent,
      this.showAvatar = true})
      : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initContent ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Modular.get<AuthController>().currentUser;

    return Padding(
      padding: widget.contentPadding ??
          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: currentUser.isBanned
          ? Text(t.Feed.not_allowed_comment)
          : Row(
              children: <Widget>[
                if (widget.showAvatar)
                  UserAvatar(
                    photo: currentUser.photoUrl,
                    showBadge: false,
                    radius: 40,
                  ).padding(right: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.all(12),
                      hintText: t.Feed.type_comment,
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onTap: _onSend,
                      ),
                    ),
                    onEditingComplete: _onSend,
                  ),
                ),
              ],
            ),
    );
  }

  void _onSend() async {
    final content = controller.text.trim();
    if (content.isEmpty) return;
    widget.onSubmit(content);
    await Future.delayed(Duration(milliseconds: 50));
    controller.clear();
  }
}
