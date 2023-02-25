import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/about_us_bloc/about_us_bloc.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.aboutUs.tr(context),
        ),
      ),
      body: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          if (state.status == AboutUsStatus.loading) {
            return LoadingView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.status == AboutUsStatus.error) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.status == AboutUsStatus.loaded) {
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSize.s15.h),
                  child: Image.asset(
                    ImageAssets.asrar,
                    height: AppSize.s250.h,
                    width: AppSize.s250.w,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Text(
                  state.aboutUs,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: getAlmaraiRegularStyle(
                    fontSize: AppSize.s22.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
