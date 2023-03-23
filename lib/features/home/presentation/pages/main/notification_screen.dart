import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/strings_manager.dart';
import '../../blocs/notification_bloc/notification_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';
import '../../widgets/general/notification_view.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.notification.tr(context),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state.notificationStatus == NotificationStatus.loading) {
            return LoadingView(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.notificationStatus == NotificationStatus.error) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          } else if (state.notificationStatus == NotificationStatus.success &&
              state.notificationList.isNotEmpty) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.notificationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NotificationView(
                    notificationInfo: state.notificationList[index],
                  );
                });
          } else if (state.notificationStatus == NotificationStatus.success &&
              state.notificationList.isEmpty) {
            return EmptyListView(
              emptyListMessage: AppStrings.noNotifications.tr(context),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
