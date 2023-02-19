import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/color_manager.dart';
import 'loading_view.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  CachedNetworkImageWidget({
    super.key,
    required this.image,
    required this.shapeBorder,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.height = 0,
    this.width = 0,
    this.blurRadius=4,
    this.offset=Offset.zero,
    this.boxFit=BoxFit.fill,
  });
  final String image;
  final ShapeBorder shapeBorder;
  final double horizontalMargin;
  final double verticalMargin;
  final double height;
  final double width;
  final double blurRadius;
  final Offset offset;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: image,
      fit: boxFit,
      imageBuilder: (context, imageProvider) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: blurRadius,
                spreadRadius: 1,
                offset: offset
              ),
            ],
            shape: shapeBorder,
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return LoadingView(
          height: height,
          width: width,
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.error,
          color: ColorManager.error,
        );
      },
    );
  }
}
