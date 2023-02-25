import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../blocs/terms_of_use_bloc/terms_of_use_bloc.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.termsOfUse.tr(context),
        ),
      ),
      body: BlocBuilder<TermsOfUseBloc, TermsOfUseState>(
        builder: (context, state) {
          if (state.status == TermsOfUseStatus.loading) {
            return LoadingView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.status == TermsOfUseStatus.error) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.status == TermsOfUseStatus.loaded) {
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: AppSize.s10.h),
              children: [
                Text(
                  state.termsOfUse,
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
