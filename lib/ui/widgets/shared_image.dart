import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'package:aura_app/core/theme/colors.dart';

class Img extends StatelessWidget {
  final String url;
  final double? w, h;
  final BoxFit fit;
  final double r;

  const Img(this.url,
      {super.key, this.w, this.h, this.fit = BoxFit.cover, this.r = 0});

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(r),
        child: url.startsWith('http')
            ? CachedNetworkImage(
                imageUrl: url,
                width: w,
                height: h,
                fit: fit,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (c, u) => Shimmer.fromColors(
                    baseColor: context.colors.n200,
                    highlightColor: context.colors.n100,
                    child: Container(width: w, height: h, color: context.colors.n200)),
                errorWidget: (c, u, e) => Container(
                    width: w,
                    height: h,
                    color: context.colors.n100,
                    child: Center(
                        child: Icon(Icons.image_outlined,
                            color: context.colors.n300, size: 28))),
              )
            : Image.asset(url, width: w, height: h, fit: fit),
      );
}

/// Primary action button
