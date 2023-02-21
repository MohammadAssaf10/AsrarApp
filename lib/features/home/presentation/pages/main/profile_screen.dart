import 'package:asrar_app/config/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../config/color_manager.dart';
import '../../../../../config/strings_manager.dart';
import '../../../../../config/styles_manager.dart';
import '../../../../../config/values_manager.dart';
import '../../../../../core/app/functions.dart';
import '../../../../auth/presentation/bloc/authentication_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../widgets/general/error_view.dart';
import '../../widgets/general/home_button_widgets.dart';
import '../../widgets/general/loading_view.dart';
import '../../widgets/general/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.profile.tr(context))),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is ImageUpdatedSuccessfullyState) {
            showCustomDialog(context,
                message: AppStrings.profileImageUpdated.tr(context));
            BlocProvider.of<UserBloc>(context).add(
              GetUserInfo(email: authState.user!.email),
            );
          }
          if (state is PasswordUpdatedLoadingState) {
            showCustomDialog(context);
          }
          if (state is PasswordUpdatedErrorState) {
            showCustomDialog(context, message: state.errorMessage.tr(context));
            BlocProvider.of<UserBloc>(context).add(
              GetUserInfo(email: authState.user!.email),
            );
          }
          if (state is PasswordUpdatedSuccessfullyState) {
            showCustomDialog(context,
                message: AppStrings.passwordUpdated.tr(context));
            BlocProvider.of<UserBloc>(context).add(
              GetUserInfo(email: authState.user!.id),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState)
            return LoadingView(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
            );
          else if (state is UserErrorState)
            return ErrorView(
              errorMessage: state.errorMessage,
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
            );
          else if (state is UserLoadedState)
            return ListView(
              shrinkWrap: true,
              children: [
                ProfileImage(
                  userImage: state.user.imageURL,
                  imagePicked: image?.path,
                  onPress: () async {
                    XFile? imageSelected = await selectFile(context);
                    setState(() {
                      image = imageSelected;
                    });
                  },
                ),
                Text(
                  state.user.name,
                  textAlign: TextAlign.center,
                  style: getAlmaraiBoldStyle(
                    fontSize: AppSize.s20.sp,
                    color: ColorManager.primary,
                  ),
                ),
                image == null
                    ? SizedBox(height: AppSize.s60.h)
                    : Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSize.s15.h),
                        child: OptionButton(
                          onTap: () {
                            BlocProvider.of<UserBloc>(context).add(
                              UpdateUserImageEvent(email: authState.user!.id, image: image!),
                            );
                            image = null;
                          },
                          title: AppStrings.save.tr(context),
                          height: AppSize.s30.h,
                          width: AppSize.s120.w,
                          fontSize: AppSize.s20.sp,
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s10.w,
                    vertical: AppSize.s5.h,
                  ),
                  child: Text(
                    AppStrings.advancedSettings.tr(context),
                    textAlign: TextAlign.start,
                    style: getAlmaraiBoldStyle(
                      fontSize: AppSize.s22.sp,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showNewPasswordDialog(
                      context,
                      newPasswordController,
                      () {
                        // BlocProvider.of<UserBloc>(context).add(
                        //   UpdatePasswordEvent(
                        //       newPassword: newPasswordController.text),
                        // );
                        final UserRepository userRepository =
                            UserRepositoryImpl();
                        userRepository.updateUserInfo(authState.user!,
                            "Mohamadassaf@test.com", "Mohamad assaf", "963968609046");
                      },
                    );
                  },
                  title: Row(
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        size: AppSize.s25.sp,
                      ),
                      SizedBox(width: AppSize.s8.w),
                      Text(
                        AppStrings.changePassword.tr(context),
                        style: getAlmaraiRegularStyle(
                          fontSize: AppSize.s18.sp,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: AppSize.s20.sp,
                  ),
                ),
              ],
            );
          return SizedBox();
        },
      ),
    );
  }
}
