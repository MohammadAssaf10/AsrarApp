import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/assets_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          AppStrings.asrarForElectronicServices.tr(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(IconAssets.notification),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(IconAssets.share),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.s10.h, horizontal: AppSize.s12.w,),
            child: Image.asset(ImageAssets.maskGroup),
          )
        ],
      ),
    );
  }
}
