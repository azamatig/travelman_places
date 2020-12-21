import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'export.dart';
import 'presentation/posts/index.dart';

class AdminModule extends m.ChildModule {
  @override
  List<m.Bind> get binds => [
        m.Bind((i) => AdminRepo()),
      ];

  @override
  List<m.ModularRouter> get routers => [];

  static Future toReportedPosts() => _to(ReportedPosts());
  static Future _to(Widget screen) =>
      m.Modular.to.navigator.push(MaterialPageRoute(builder: (_) => screen));
}
