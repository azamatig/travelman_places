import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../export.dart';

class RepliesWidget extends StatelessWidget {
  final List<Comment> replies;

  const RepliesWidget({Key key, this.replies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentUserId = Modular.get<AuthController>().currentUser.id;
    final theme = Theme.of(context);

    return Column(
      children: <Widget>[
        for (final reply in replies.take(4).toList())
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: <Widget>[
                SizedBox(width: 30),
                UserAvatar(
                  photo: reply.authorPhotoUrl,
                  radius: 30,
                  showBadge: false,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: reply.authorId == currentUserId
                              ? 'Me:  '
                              : '${reply.authorName ?? ''}:  ',
                          style: theme.textTheme.subtitle1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: reply.content),
                      ],
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
