import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/assets.dart';
import '../core/custom_cache_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;

  const CustomNetworkImage({
    Key key,
    this.url = '',
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return kIsWeb || Platform.isMacOS
        ? FadeInImage(
            image: NetworkImage(url),
            width: width,
            height: height,
            fit: fit,
            placeholder: AssetImage(AssetsHelper.LOADING),
          )
        : CachedNetworkImage(
            cacheManager: CustomCacheManager(),
            imageUrl: url,
            fit: fit,
            width: width,
            height: height,
            placeholder: (context, _) =>
                placeholder ?? Image.asset(AssetsHelper.LOADING),
            errorWidget: (context, _, __) =>
                errorWidget ??
                Image.asset(AssetsHelper.BLURRED_PIC, fit: BoxFit.fill),
          );
  }
}

//ignore: non_constant_identifier_names
ImageProvider CustomNetworkImageProvider(String url,
        {double scale, ErrorListener errorListener}) =>
    kIsWeb || Platform.isMacOS
        ? NetworkImage(url, scale: scale)
        : CachedNetworkImageProvider(
            url,
            scale: scale,
            cacheManager: CustomCacheManager(),
          );
