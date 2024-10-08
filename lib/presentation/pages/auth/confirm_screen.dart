import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/application/auth/auth_bloc.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/presentation/components/blur_wrap.dart';
import 'package:ibeauty/presentation/components/button/custom_button.dart';
import 'package:ibeauty/presentation/pages/auth/widgets/send_again_button.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ConfirmScreen extends StatefulWidget {
  final CustomColorSet colors;
  final String phone;
  final bool editPhone;

  const ConfirmScreen(
      {super.key,
      required this.colors,
      required this.phone,
      this.editPhone = false});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.editPhone
        ? _editPhone()
        : BlurWrap(
            radius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                color: CustomStyle.black.withOpacity(0.25),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                FlutterRemix.arrow_left_line,
                                color: widget.colors.white,
                                size: 26.r,
                              )),
                          const Spacer(),
                          Text(
                            AppHelper.getTrn(TrKeys.enterOtpCode),
                            style: CustomStyle.interNoSemi(
                                color: widget.colors.white, size: 20),
                          ),
                          const Spacer(),
                          SizedBox(width: 42.r)
                        ],
                      ),
                      16.verticalSpace,
                      Center(
                        child: Text(
                          "${AppHelper.getTrn(TrKeys.weAreSendOTPCodeTo)} ${widget.phone}",
                          style: CustomStyle.interRegular(
                            size: 16,
                            color: widget.colors.white,
                          ),
                        ),
                      ),
                      24.verticalSpace,
                      SizedBox(
                        height: 64,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (n, l) {
                            return n.isError != l.isError;
                          },
                          builder: (context, state) {
                            return PinFieldAutoFill(
                              codeLength: 6,
                              controller: controller,
                              currentCode: controller.text,
                              onCodeSubmitted: (number) {
                                context.read<AuthBloc>().add(
                                    AuthEvent.checkVerify(
                                        context: context,
                                        verifyId: state.verificationId,
                                        code: number));
                              },
                              cursor: Cursor(
                                width: 1,
                                height: 24,
                                color: widget.colors.white,
                                enabled: true,
                              ),
                              decoration: BoxLooseDecoration(
                                gapSpace: 10.r,
                                textStyle: CustomStyle.interNormal(
                                  size: 15,
                                  color: widget.colors.white,
                                ),
                                bgColorBuilder: FixedColorBuilder(
                                  widget.colors.transparent,
                                ),
                                radius: Radius.circular(30.r),
                                strokeColorBuilder: FixedColorBuilder(
                                  state.isError
                                      ? widget.colors.error
                                      : widget.colors.icon,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      16.verticalSpace,
                      BlocBuilder<AuthBloc, AuthState>(
                        buildWhen: (l, n) {
                          return l.isLoading != n.isLoading;
                        },
                        builder: (context, state) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SendAgainButton(
                                    isLoading: state.isLoading,
                                    colors: widget.colors,
                                    phone: widget.phone),
                              ),
                              8.horizontalSpace,
                              Expanded(
                                flex: 2,
                                child: CustomButton(
                                    isLoading: state.isLoading,
                                    title: AppHelper.getTrn(TrKeys.confirm),
                                    bgColor: widget.colors.primary,
                                    titleColor: CustomStyle.white,
                                    onTap: () {
                                      context.read<AuthBloc>().add(
                                          AuthEvent.checkVerify(
                                              editPhone: widget.editPhone,
                                              context: context,
                                              verifyId: state.verificationId,
                                              code: controller.text));
                                    }),
                              ),
                            ],
                          );
                        },
                      ),
                      KeyboardVisibilityBuilder(builder: (s, isKeyboard) {
                        return isKeyboard
                            ? 270.verticalSpace
                            : 24.verticalSpace;
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Container _editPhone() {
    return Container(
      height: 300.r,
      decoration: BoxDecoration(color: widget.colors.backgroundColor),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppHelper.getTrn(TrKeys.confirmation),
                style: CustomStyle.interNoSemi(
                    color: widget.colors.textBlack, size: 30),
              ),
              16.verticalSpace,
              Text(
                AppHelper.getTrn(TrKeys.weAreSendOTPCodeTo),
                style: CustomStyle.interRegular(
                  size: 16,
                  color: widget.colors.textBlack,
                ),
              ),
              Text(
                widget.phone,
                style: CustomStyle.interRegular(
                  size: 16,
                  color: widget.colors.textBlack,
                ),
              ),
              24.verticalSpace,
              SizedBox(
                height: 64,
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (n, l) {
                    return n.isError != l.isError;
                  },
                  builder: (context, state) {
                    return PinFieldAutoFill(
                      codeLength: 6,
                      controller: controller,
                      currentCode: controller.text,
                      onCodeSubmitted: (number) {
                        context.read<AuthBloc>().add(AuthEvent.checkVerify(
                            context: context,
                            verifyId: state.verificationId,
                            code: number));
                      },
                      cursor: Cursor(
                        width: 1,
                        height: 24,
                        color: widget.colors.textBlack,
                        enabled: true,
                      ),
                      decoration: BoxLooseDecoration(
                        gapSpace: 10.r,
                        textStyle: CustomStyle.interNormal(
                          size: 15,
                          color: widget.colors.textBlack,
                        ),
                        bgColorBuilder: FixedColorBuilder(
                          widget.colors.transparent,
                        ),
                        strokeColorBuilder: FixedColorBuilder(
                          state.isError
                              ? widget.colors.error
                              : widget.colors.bottomBarColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              16.verticalSpace,
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (l, n) {
                  return l.isLoading != n.isLoading;
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SendAgainButton(
                            isLoading: state.isLoading,
                            colors: widget.colors,
                            phone: widget.phone),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                            isLoading: state.isLoading,
                            title: AppHelper.getTrn(TrKeys.confirm),
                            bgColor: widget.colors.primary,
                            titleColor: CustomStyle.white,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                  AuthEvent.checkVerify(
                                      editPhone: widget.editPhone,
                                      context: context,
                                      verifyId: state.verificationId,
                                      code: controller.text));
                            }),
                      ),
                    ],
                  );
                },
              ),
              KeyboardVisibilityBuilder(builder: (s, isKeyboard) {
                return isKeyboard ? 270.verticalSpace : 24.verticalSpace;
              })
            ],
          ),
        ),
      ),
    );
  }
}
