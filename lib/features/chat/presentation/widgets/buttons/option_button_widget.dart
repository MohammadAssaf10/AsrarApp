import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/app_localizations.dart';
import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/constants.dart';
import '../../../../../core/app/functions.dart';
import '../../../../home/domain/entities/service_order.dart';
import '../../../../home/presentation/blocs/service_order/service_order_bloc.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.onSended,
    required this.serviceOrder,
  }) : super(key: key);

  final Function? onSended;
  final ServiceOrder serviceOrder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BlocListener<ServiceOrderBloc, ServiceOrderState>(
        listener: (context, state) {
          if (state.processStatus == Status.loading) {
            showCustomDialog(context);
          } else if (state.processStatus == Status.failed) {
            showCustomDialog(context, message: state.message!.tr(context));
          } else if (state.processStatus == Status.success) {
            showCustomDialog(context, message: AppStrings.success.tr(context));
          }
        },
        child: InkWell(
            onTap: () async {
              onSended;
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CompletedSuccessfullyButton(serviceOrder: serviceOrder),
                      CancelOrderButton(serviceOrder: serviceOrder),
                      RiseAComplaintButton(),
                      SizedBox(
                        height: AppSize.s30.h,
                      )
                    ],
                  ),
                ),
              );
            },
            child: Icon(
              Icons.more_vert,
              color: ColorManager.primary,
            )),
      ),
    );
  }
}

class CompletedSuccessfullyButton extends StatelessWidget {
  const CompletedSuccessfullyButton({super.key, required this.serviceOrder});

  final ServiceOrder serviceOrder;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          bool confirmed = await showConfirmDialog(context);
          if (confirmed)
            BlocProvider.of<ServiceOrderBloc>(context)
                .add(CompleteOrder(serviceOrder: serviceOrder));
          dismissDialog(context);
        },
        child: Text(AppStrings.completedSuccessfully.tr(context)));
  }
}

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({super.key, required this.serviceOrder});

  final ServiceOrder serviceOrder;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          bool confirmed = await showConfirmDialog(context);
          if (confirmed)
            BlocProvider.of<ServiceOrderBloc>(context).add(CancelOrder(serviceOrder: serviceOrder));
          dismissDialog(context);
        },
        child: Text(AppStrings.cancelOrder.tr(context)));
  }
}

class RiseAComplaintButton extends StatelessWidget {
  const RiseAComplaintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: Text(AppStrings.riseAComplaint.tr(context)));
  }
}
