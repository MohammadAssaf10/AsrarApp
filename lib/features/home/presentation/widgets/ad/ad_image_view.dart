import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../blocs/ad_image_bloc/ad_image_bloc.dart';
import '../general/cached_network_image_widget.dart';
import '../general/error_view.dart';
import '../general/loading_view.dart';

class AdImageView extends StatelessWidget {
  const AdImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AdImageBloc, AdImageState>(
        builder: (context, state) {
          if (state is AdImageLoadingState) {
            return LoadingView(
              height: AppSize.s200.h,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is AdImageErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: AppSize.s200.h,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is AdImagesLoadedState) {
            if (state.adImagelist.isNotEmpty) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: state.adImagelist.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      final Uri url =
                          Uri.parse(state.adImagelist[index].adImagedeepLink);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        showCustomDialog(
                          context,
                          message: AppStrings.sorryWeCouldNotOpenThatLink
                              .tr(context),
                        );
                      }
                    },
                    child: CachedNetworkImageWidget(
                      image: state.adImagelist[index].adImageUrl,
                      height: AppSize.s220.h,
                      width: AppSize.s360.w,
                      shapeBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10.r),
                        borderSide:
                            const BorderSide(color: ColorManager.transparent),
                      ),
                      horizontalMargin: AppSize.s8.w,
                      verticalMargin: AppSize.s12.h,
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.s12.h,
                  horizontal: AppSize.s8.w,
                ),
                child: Image.asset(
                  ImageAssets.maskGroup,
                  fit: BoxFit.fill,
                  height: AppSize.s220.h,
                  width: AppSize.s360.w,
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
