import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/app_constants.dart';
import 'package:ibeauty/application/auth/auth_bloc.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/infrastructure/firebase/firebase_service.dart';
import 'package:ibeauty/infrastructure/local_storage/local_storage.dart';
import 'package:ibeauty/presentation/components/button/custom_button.dart';
import 'package:ibeauty/presentation/components/button/second_button.dart';
import 'package:ibeauty/presentation/components/custom_scaffold.dart';
import 'package:ibeauty/presentation/route/app_route.dart';
import 'package:ibeauty/presentation/route/app_route_setting.dart';
import 'package:ibeauty/presentation/style/style.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late TextEditingController phone;

  @override
  void initState() {
    phone = TextEditingController();
    FirebaseService.initDynamicLinks(context);
    super.initState();
  }

  @override
  void dispose() {
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.loginBg),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScaffold(
        bgColor: CustomStyle.transparent,
        body: (colors) => BlocListener<AuthBloc, AuthState>(
          listenWhen: (prev, next) {
            return prev.screenType.name != next.screenType.name;
          },
          listener: (context, state) {
            if (state.screenType == AuthType.confirm) {
              AppRoute.goConfirmBottomSheet(context, colors, phone.text);
              return;
            }
            if (state.screenType == AuthType.signUpFull) {
              AppRoute.goSignUpFieldBottomSheet(context, colors, phone.text);
              return;
            }
            if (state.screenType == AuthType.updatePassword) {
              AppRoute.goUpdatePasswordBottomSheet(context, colors, phone);
              return;
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Column(
                children: [
                  16.verticalSpace,
                  Row(
                    children: [
                      Text(
                        AppHelper.getAppName(),
                        style:
                            CustomStyle.interNormal(color: CustomStyle.white),
                      ),
                      const Spacer(),
                      SecondButton(
                        title: AppHelper.getTrn(TrKeys.skip),
                        bgColor: CustomStyle.black,
                        titleColor: CustomStyle.white,
                        onTap: () {
                          if (LocalStorage.getAddress() == null) {
                            AppRouteSetting.goSelectCountry(context: context);
                            return;
                          }
                          if (AppConstants.isDemo &&
                              LocalStorage.getUiType() == null) {
                            AppRouteSetting.goSelectUIType(context: context);
                            return;
                          }
                          AppRoute.goMain(context);
                        },
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(
                    AppHelper.getTrn(TrKeys.findTheBestServicesInYourCity),
                    style:
                        CustomStyle.interNormal(color: colors.white, size: 35),
                    textAlign: TextAlign.center,
                  ),
                  32.verticalSpace,
                  CustomButton(
                      title: AppHelper.getTrn(TrKeys.login),
                      bgColor: colors.primary,
                      titleColor: colors.white,
                      onTap: () {
                        AppRoute.goLoginBottomSheet(context, colors, phone);
                      }),
                  10.verticalSpace,
                  CustomButton(
                      title: AppHelper.getTrn(TrKeys.signUp),
                      bgColor: colors.transparent,
                      titleColor: colors.white,
                      borderColor: colors.white,
                      onTap: () {
                        AppRoute.goSignUpBottomSheet(context, colors, phone);
                      }),
                  32.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}