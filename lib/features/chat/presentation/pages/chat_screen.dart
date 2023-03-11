import 'package:asrar_app/config/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_localizations.dart';
import '../../../../config/color_manager.dart';
import '../../../../config/strings_manager.dart';
import '../../../../config/values_manager.dart';
import '../../../../core/app/constants.dart';
import '../../../../core/app/functions.dart';
import '../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../../home/domain/entities/service_order.dart';
import '../../../home/presentation/widgets/general/cached_network_image_widget.dart';
import '../blocs/chat_bloc/chat_bloc.dart';
import '../functions/functions.dart';
import '../widgets/buttons/chat_bottom_widget.dart';
import '../widgets/messages/message_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.serviceOrder});

  final ServiceOrder serviceOrder;
  final ScrollController _scrollController = ScrollController();

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: -5.w,
      title: Row(
        children: [
          serviceOrder.user.imageURL.isNotEmpty
              ? CachedNetworkImageWidget(
                  image: serviceOrder.user.imageURL,
                  shapeBorder: const CircleBorder(),
                  height: AppSize.s45.h,
                  width: AppSize.s45.w,
                  boxFit: BoxFit.cover,
                  blurRadius: 0,
                )
              : Card(
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.person,
                    size: AppSize.s45.sp,
                    color: ColorManager.grey,
                  ),
                ),
          SizedBox(width: AppSize.s10.w),
          Text(
            serviceOrder.employee.name,
            style: getAlmaraiBoldStyle(
              fontSize: AppSize.s18.sp,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: serviceOrder.employee.name.isEmpty
          ? AppBar(
              title: Text(
                AppStrings.waitingForAcceptingTheService.tr(context),
              ),
            )
          : getAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.fileUploadingStatus == Status.loading) {
                  showCustomDialog(context);
                } else if (state.fileUploadingStatus == Status.success) {
                  dismissDialog(context);
                } else if (state.fileUploadingStatus == Status.failed) {
                  showCustomDialog(context, message: state.message);
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: state.messagesList.length,
                  itemBuilder: (context, index) {
                    var message = state.messagesList[index];
                    var isMine = message.isMine(
                        BlocProvider.of<AuthenticationBloc>(context)
                            .state
                            .user!
                            .id);

                    return Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isMine) const SizedBox(),
                        MessageWidget(
                          message: state.messagesList[index],
                          isMine: isMine,
                          isPreviousFromTheSameSender:
                              isPreviousFromTheSameSender(
                                  state.messagesList, index),
                        ),
                        if (isMine) const SizedBox(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          ChatBottom(
              serviceOrder: serviceOrder,
              onSended: () {
                _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              }),
        ],
      ),
    );
  }
}
