import 'package:asrar_app/config/app_localizations.dart';
import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../domain/entities/service_entities.dart';
import '../general/input_form_field.dart';
import 'service_widget.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key, required this.servicesList});
  final List<ServiceEntities> servicesList;

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final TextEditingController controller = TextEditingController();
  List<ServiceEntities> servicesEntitiesList = [];

  @override
  void initState() {
    servicesEntitiesList = widget.servicesList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppSize.s40.h,
          margin: EdgeInsets.symmetric(
            horizontal: AppSize.s10.w,
            vertical: AppSize.s10.h,
          ),
          child: InputFormField(
            onChanage: (v) {
              if (v.isEmpty) {
                servicesEntitiesList = widget.servicesList;
              } else {
                servicesEntitiesList = widget.servicesList
                    .where((service) => service.serviceName
                        .toLowerCase()
                        .contains(v.toLowerCase()))
                    .toList();
              }
              setState(() {});
            },
            suffixIcon: Icon(Icons.search),
            controller: controller,
            labelText: AppStrings.searchForYourServices.tr(context),
            regExp: getTextWithNumberInputFormat(),
            textInputType: TextInputType.text,
            horizontalContentPadding: AppSize.s12.w,
          ),
        ),
        servicesEntitiesList.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: servicesEntitiesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ServiceWidget(
                      service: servicesEntitiesList[index],
                    );
                  },
                ),
              )
            : Expanded(
                child: Center(
                  child: Text(
                    AppStrings.noServices.tr(context),
                    textAlign: TextAlign.center,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s16.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
