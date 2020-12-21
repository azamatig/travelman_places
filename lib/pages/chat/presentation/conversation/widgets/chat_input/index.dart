import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:travelman/pages/chat/i18n/strings.g.dart';
import '../../../../export.dart';
import 'controller.dart';

class ChatInput extends WidgetModule {
  final VoidCallback onSend;
  final Message toEditMessage;
  ChatInput({
    @required this.onSend,
    this.toEditMessage,
  });
  @override
  List<Bind> get binds =>
      [Bind((_) => ChatInputController(onSend, toEditMessage))];

  @override
  Widget get view => _ChatInput();
}

class _ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends ModularState<_ChatInput, ChatInputController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 12),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller.controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).primaryColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    hintText: t.Chat.message,
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: controller.toEditMessage != null
                        ? null
                        : GestureDetector(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onTap: () => controller.onSendImage(context),
                          ),
                  ),
                  onEditingComplete: controller.sendTextMessage,
                  onChanged: (s) {
                    if (s.isNotEmpty && !controller.isTyping) {
                      controller.isTyping = true;
                    } else if (s.isEmpty) {
                      controller.isTyping = false;
                    }
                  },
                ).constrained(maxWidth: 100),
              ),
              SizedBox(width: 4),
              GestureDetector(
                onTap: controller.sendTextMessage,
                child: CircleAvatar(
                  radius: 35,
                  child: Icon(
                    Icons.send,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: TweenAnimationBuilder(
          //     tween: Tween<double>(
          //       begin: controller.isTyping ? 1 : 0,
          //       end: controller.isTyping ? 0 : 1,
          //     ),
          //     duration: Duration(milliseconds: 200),
          //     builder: (_, scale, __) => Transform.scale(
          //       origin: Offset(200, 0),
          //       scale: scale,
          //       child: VoiceRecorderWidget(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
