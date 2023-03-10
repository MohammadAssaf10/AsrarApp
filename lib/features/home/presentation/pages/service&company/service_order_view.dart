import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../blocs/service_order/service_order_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';
import '../../widgets/service/service_order_card.dart';

class ServiceOrderView extends StatelessWidget {
  const ServiceOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceOrderBloc, ServiceOrderState>(
      listener: (context, state) {
        if (state.processStatus == Status.loading) {
          showCustomDialog(context);
        } else if (state.processStatus == Status.failed) {
          showCustomDialog(context, message: state.message);
        } else {
          dismissDialog(context);
        }
      },
      builder: (context, state) {
        if (state.serviceOrderListStatus == Status.loading) {
          return LoadingView(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.serviceOrderListStatus == Status.failed) {
          return ErrorView(
            errorMessage: state.message!.tr(context),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state.serviceOrderListStatus == Status.success) {
          if (state.serviceOrderList.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                var user =
                    BlocProvider.of<AuthenticationBloc>(context).state.user!;
                BlocProvider.of<ServiceOrderBloc>(context)
                    .add(GetOrders(user: user));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: EmptyListView(
                  emptyListMessage: AppStrings.noOrders.tr(context),
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.serviceOrderList.length,
              itemBuilder: (BuildContext context, int index) {
                return ServiceOrderCard(
                  order: state.serviceOrderList[index],
                );
              },
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
