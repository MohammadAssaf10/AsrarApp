import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../config/color_manager.dart';
import 'loading_view.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  CachedNetworkImageWidget({
    super.key,
    required this.image,
    required this.shapeBorder,
    required this.offset,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.height = 0,
    this.width = 0,
  });
  final String image;
  final ShapeBorder shapeBorder;
  final Offset offset;
  final double horizontalMargin;
  final double verticalMargin;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: verticalMargin,
          ),
          decoration: ShapeDecoration(
            shadows: [
              BoxShadow(
                color: ColorManager.grey,
                blurRadius: 4.0,
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
      placeholder: (context, url) {
        return LoadingView(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
