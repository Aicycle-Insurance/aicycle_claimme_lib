import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Use for Network Image
class CachedImageWidget extends StatelessWidget {
  final String url;
  final Alignment alignment;
  final double? borderRadius;
  final BoxShape? shape;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  const CachedImageWidget({
    super.key,
    required this.url,
    this.borderRadius,
    this.alignment = Alignment.topLeft,
    this.fit,
    this.shape,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius:
              shape == null ? BorderRadius.circular(borderRadius ?? 0) : null,
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
      fit: BoxFit.cover,
      alignment: alignment,
      memCacheHeight: 150,
      memCacheWidth: 150,
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.white,
          ),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }
}

CachedNetworkImageProvider cachedNetworkImageProvider(url) =>
    CachedNetworkImageProvider(
      url,
    );
