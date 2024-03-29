import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asrar_app/config/app_localizations.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/routes_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../../chat/presentation/blocs/support_chat/support_chat_bloc.dart';
import '../../blocs/subscription_bloc/subscription_bloc.dart';
import '../../widgets/general/empty_list_view.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/loading_view.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.otherServices.tr(context),
        ),
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionLoadingState) {
            return LoadingView(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is SubscriptionErrorState) {
            return ErrorView(
              errorMessage: state.errorMessage.tr(context),
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
            );
          } else if (state is SubscriptionsLoadedState) {
            if (state.subscriptionList.isNotEmpty) {
              return ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: state.subscriptionList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        final authState =
                            BlocProvider.of<AuthenticationBloc>(context).state;
                        if (authState.status == AuthStatus.loggedIn) {
                          Navigator.pushNamed(context, Routes.supportRoute,
                              arguments: authState.user);
                          BlocProvider.of<SupportChatBloc>(context)
                              .add(ChatStarted());
                        } else {
                          showLoginDialog(context);
                        }
                      },
                      child: Container(
                        height: AppSize.s45.h,
                        width: MediaQuery.of(context).size.width / 1.1,
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.s8.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.s15.w,
                        ),
                        decoration: ShapeDecoration(
                          color: ColorManager.primary,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s16.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.subscriptionList[index].subscriptionName,
                              style: getAlmaraiBoldStyle(
                                fontSize: AppSize.s18.sp,
                                color: ColorManager.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: AppSize.s4.h),
                            Visibility(
                              visible: state.subscriptionList[index]
                                          .subscriptionPrice ==
                                      ""
                                  ? false
                                  : true,
                              child: Text(
                                state.subscriptionList[index].subscriptionPrice
                                        .startsWith("0")
                                    ? AppStrings.free.tr(context)
                                    : "${state.subscriptionList[index].subscriptionPrice} ر.س",
                                textDirection: TextDirection.rtl,
                                style: getAlmaraiRegularStyle(
                                  fontSize: AppSize.s16.sp,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return EmptyListView(
                emptyListMessage: AppStrings.noServices.tr(context),
                height: MediaQuery.of(context).size.height / 1.2,
                width: MediaQuery.of(context).size.width,
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
