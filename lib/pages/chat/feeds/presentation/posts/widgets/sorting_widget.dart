import 'package:flutter/material.dart';
import '../../../export.dart';

class PostsSortingWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final PostQuery postQuery;
  final void Function(PostQuery value) onChange;

  const PostsSortingWidget({Key key, this.onChange, this.postQuery})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final s in PostQuery.values)
            GestureDetector(
              onTap: () => onChange(s),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.5),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: 95,
                      decoration: BoxDecoration(
                          color:
                              s == postQuery ? Colors.white : Colors.grey[300],
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text(s.text)),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
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
