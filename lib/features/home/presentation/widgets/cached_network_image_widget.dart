import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.image,
    required this.shapeBorder,
    required this.offset,
    required this.horizontalMargin,
    required this.verticalMargin,
  });
  final String image;
  final ShapeBorder shapeBorder;
  final Offset offset;
  final double horizontalMargin;
  final double verticalMargin;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fill,
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
                blurRadius: 2.0,
                offset: offset,
              ),
            ],
            shape: shapeBorder,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: ColorManager.primary,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: ColorManager.error,
      ),
    );
  }
}
