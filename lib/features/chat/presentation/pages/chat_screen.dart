import 'package:cached_network_image/cached_network_image.dart';
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
import '../blocs/chat_bloc/chat_bloc.dart';
import '../functions/functions.dart';
import '../widgets/buttons/chat_bottom_widget.dart';
import '../widgets/messages/message_widget.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.serviceOrder});

  final ServiceOrder serviceOrder;
  final ScrollController _scrollController = ScrollController();

  AppBar getAppBar(BuildContext context) {
    if (serviceOrder.employee.name.isEmpty)
      return AppBar(
        title: Text(AppStrings.waitingForAcceptingTheService.tr(context)),
      );
    else
      return AppBar(
        title: Row(
          children: [
            Text(serviceOrder.employee.name),
            Container(
              height: AppSize.s30.h,
              width: AppSize.s30.w,
              constraints: BoxConstraints(
                maxHeight: AppSize.s30.h,
                maxWidth: AppSize.s30.w,
              ),
              child: CachedNetworkImage(
                imageUrl: serviceOrder.user.imageURL,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(
                  Icons.person_pin,
                  color: ColorManager.grey,
                ),
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
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
                    var isMine =
                        message.isMine(BlocProvider.of<AuthenticationBloc>(context).state.user!.id);

                    return Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isMine) SizedBox(),
                        MessageWidget(
                          message: state.messagesList[index],
                          isMine: isMine,
                          isPreviousFromTheSameSender:
                              isPreviousFromTheSameSender(state.messagesList, index),
                        ),
                        if (isMine) SizedBox(),
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
                _scrollController.animateTo(_scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
              }),
        ],
      ),
    );
  }
}
