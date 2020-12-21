import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class CustomCacheManager extends BaseCacheManager {
  static const key = 'customCache';

  static CustomCacheManager _instance;

  factory CustomCacheManager() {
    _instance ??= CustomCacheManager._();
    return _instance;
  }

  CustomCacheManager._()
      : super(
          key,
          maxAgeCacheObject: Duration(days: 1),
          maxNrOfCacheObjects: 20,
        );

  @override
  Future<String> getFilePath() async =>
      p.join((await getTemporaryDirectory()).path, key);
}
