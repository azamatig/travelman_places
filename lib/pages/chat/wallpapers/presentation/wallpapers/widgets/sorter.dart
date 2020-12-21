import 'package:flutter/material.dart';
import '../../../export.dart';

class CategoriesSortWidget extends StatelessWidget with PreferredSizeWidget {
  final WallpapersQuery query;
  final void Function(WallpapersQuery v) onChange;

  CategoriesSortWidget({Key key, this.query, this.onChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final s in WallpapersQuery.values)
            GestureDetector(
              onTap: () => onChange(s),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Chip(
                  backgroundColor: s == query ? Colors.grey : null,
                  label: Text(s.text),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
