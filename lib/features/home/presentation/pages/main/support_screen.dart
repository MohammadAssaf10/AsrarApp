import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../../config/strings_manager.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.support.tr(context)),
      ),
    );
  }
}
