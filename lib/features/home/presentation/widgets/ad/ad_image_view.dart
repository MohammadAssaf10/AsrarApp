import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/ad_image_bloc/ad_image_bloc.dart';
import '../general/cached_network_image_widget.dart';

class AdImageView extends StatelessWidget {
  const AdImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdImageBloc, AdImageState>(
      builder: (context, state) {
        if (state is AdImageLoadingState)
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.s85.h),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.primary,
              ),
            ),
          );
        else if (state is AdImageErrorState)
          return Container(
            margin: EdgeInsets.symmetric(vertical: AppSize.s90.h),
            alignment: Alignment.center,
            child: Text(
              state.errorMessage.tr(context),
              style: getAlmaraiRegularStyle(
                fontSize: AppSize.s20.sp,
                color: ColorManager.error,
              ),
            ),
          );
        else if (state is AdImageLoadedState) if (state.list.isNotEmpty)
          return Container(
            height: AppSize.s200.h,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.list.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImageWidget(
                  image: state.list[index].url,
                  height: AppSize.s220.h,
                  width: AppSize.s340.w,
                  shapeBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s10.r),
                    borderSide: BorderSide(color: ColorManager.transparent)
                  ),
                  offset: Offset(0,0),
                  horizontalMargin: AppSize.s10.w,
                  verticalMargin: AppSize.s12.h,
                );
              },
            ),
          );
        else
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.s12.h,
              horizontal: AppSize.s12.w,
            ),
            child: Image.asset(
              ImageAssets.maskGroup,
              width: double.infinity,
            ),
          );
        return SizedBox();
      },
    );
  }
}
