import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/application/notification/notification_bloc.dart';
import 'package:ibeauty/domain/di/dependency_manager.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/infrastructure/local_storage/local_storage.dart';
import 'package:ibeauty/presentation/components/button/custom_button.dart';
import 'package:ibeauty/presentation/components/button/pop_button.dart';
import 'package:ibeauty/presentation/components/custom_scaffold.dart';
import 'package:ibeauty/presentation/route/app_route.dart';
import 'package:ibeauty/presentation/route/app_route_setting.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';

import 'widgets/button_item.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: (colors) => SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                16.horizontalSpace,
                Text(
                  AppHelper.getTrn(TrKeys.account),
                  style: CustomStyle.interNoSemi(
                      color: colors.textBlack, size: 18),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (LocalStorage.getToken().isEmpty) {
                        AppRoute.goLogin(context);
                        return;
                      }
                      AppRouteSetting.goNotification(context: context);
                    },
                    icon: Badge(
                      label: (LocalStorage.getToken().isEmpty)
                          ? const Text("0")
                          : BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                return Text(state
                                        .countOfNotifications?.notification
                                        .toString() ??
                                    "0");
                              },
                            ),
                      child: Icon(
                        FlutterRemix.notification_line,
                        color: colors.textBlack,
                      ),
                    ))
              ],
            ),
            24.verticalSpace,
            ButtonItem(
                icon: FlutterRemix.settings_3_line,
                title: AppHelper.getTrn(TrKeys.editAccount),
                onTap: () {
                  AppRouteSetting.goEditProfile(
                      context: context, colors: colors);
                },
                colors: colors),
            ButtonItem(
                icon: FlutterRemix.lock_2_line,
                title: AppHelper.getTrn(TrKeys.changePassword),
                onTap: () {
                  AppRouteSetting.goChangePassword(
                      context: context, colors: colors);
                },
                colors: colors),
            ButtonItem(
                icon: FlutterRemix.hotel_line,
                title: AppHelper.getTrn(TrKeys.deliveryAddress),
                onTap: () {
                  AppRouteSetting.goSelectCountry(context: context);
                },
                colors: colors),
            if (LocalStorage.getToken().isNotEmpty)
              ButtonItem(
                colors: colors,
                icon: FlutterRemix.logout_box_line,
                title: AppHelper.getTrn(TrKeys.deleteAccount),
                onTap: () {
                  AppHelper.showCustomDialog(
                      context: context,
                      content: Container(
                        decoration: BoxDecoration(
                            color: colors.backgroundColor,
                            borderRadius: BorderRadius.circular(8.r)),
                        padding: EdgeInsets.all(16.r),
                        child: _deleteAlert(colors, context),
                      ));
                },
              ),
          ],
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingButton: (colors) => PopButton(colors: colors),
    );
  }

  Widget _deleteAlert(CustomColorSet colors, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppHelper.getTrn(TrKeys.areYouSureDeleteAccount),
          style: CustomStyle.interNormal(color: colors.textBlack, size: 18),
        ),
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  title: AppHelper.getTrn(TrKeys.back),
                  bgColor: colors.newBoxColor,
                  titleColor: colors.textBlack,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ),
            16.horizontalSpace,
            Expanded(
              child: CustomButton(
                  title: AppHelper.getTrn(TrKeys.yes),
                  bgColor: colors.primary,
                  titleColor: colors.white,
                  onTap: () {
                    AppRoute.goLogin(context);
                    authRepository.deleteAccount();
                  }),
            )
          ],
        )
      ],
    );
  }
}
