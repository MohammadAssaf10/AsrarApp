import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../config/assets_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/company_entities.dart';
import '../../widgets/general/input_form_field.dart';
import '../../widgets/service/services_view.dart';

class ServicesScreen extends StatelessWidget {
  final CompanyEntities company;
  ServicesScreen(this.company);
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(company.name)),
      body: ListView(
        children: [
          SizedBox(height: AppSize.s10.h),
          Container(
            height: AppSize.s45.h,
            margin: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
            child: Row(
              children: [
                Expanded(
                  child: InputFormField(
                    controller: controller,
                    labelText: AppStrings.searchForYourServices.tr(context),
                    regExp: getTextWithNumberInputFormat(),
                    height: AppSize.s40.h,
                    textInputType: TextInputType.text,
                    horizontalContentPadding: AppSize.s12.w,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    IconAssets.search,
                    height: AppSize.s20.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.s10.h),
          ServicesView(),
        ],
      ),
    );
  }
}
