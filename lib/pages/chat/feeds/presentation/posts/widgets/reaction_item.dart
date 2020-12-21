import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timeago/timeago.dart';
import '../../../export.dart';
import 'user_avatar.dart';

class ReactionItem extends StatelessWidget {
  final PostReaction reaction;

  const ReactionItem({Key key, this.reaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMe = Modular.get<AuthController>().currentUser.id ==
        reaction.reactionOwnerId;

    return ListTile(
      leading: UserAvatar(
        photo: reaction.reactionOwnerPhotoUrl,
        showBadge: false,
        radius: 40,
      ),
      title: Text(
        isMe ? 'Me: ' : '${reaction.reactionOwnerName ?? ''}: ',
        style: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          format(reaction.publishDate, locale: 'en_short'),
          style: theme.textTheme.subtitle2,
        ),
      ),
      onTap: isMe || reaction.reactionOwnerId == null
          ? null
          : () {
              AuthModule.toOtherUserProfile(reaction.reactionOwnerId);
            },
    );
  }
}
