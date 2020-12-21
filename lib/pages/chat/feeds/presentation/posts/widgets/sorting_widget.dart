import 'package:flutter/material.dart';
import '../../../export.dart';

class PostsSortingWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final PostQuery postQuery;
  final void Function(PostQuery value) onChange;


  const PostsSortingWidget({Key key, this.onChange, this.postQuery}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final s in PostQuery.values)
            GestureDetector(
              onTap:()=> onChange(s),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Chip(
                  backgroundColor: s == postQuery ? Colors.grey : null,
                  label: Text(s.text),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 40);
}
