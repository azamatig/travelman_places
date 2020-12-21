import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../export.dart';

class ReportScreen extends StatelessWidget {
  final Post post;
  ReportScreen({Key key, this.post}) : super(key: key);

  final controller = Modular.get<FeedController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.Report.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              t.Report.desc,
              style: theme.textTheme.headline6,
            ),
            SizedBox(height: 30),
            Text(t.Report.report_reasons),
            Spacer(),
            Text(
              t.Report.note,
              style: theme.textTheme.caption,
            ),
            SizedBox(height: 20),
            Center(
              child: CustomButton(
                t.Report.title,
                onTap: () {
                  controller.reportPost(post);
                  Navigator.pop(context);
                  BotToast.showText(text: t.Report.thanks);
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
