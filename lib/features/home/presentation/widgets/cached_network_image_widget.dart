import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/color_manager.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.image,
    required this.boxShape,
  });
  final String image;
  final BoxShape boxShape;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
          shape: boxShape,
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
