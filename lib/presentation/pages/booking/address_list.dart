import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/application/booking/booking_bloc.dart';
import 'package:ibeauty/application/checkout/checkout_bloc.dart';
import 'package:ibeauty/domain/model/model/master_model.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/infrastructure/local_storage/local_storage.dart';
import 'package:ibeauty/presentation/components/button/animation_button_effect.dart';
import 'package:ibeauty/presentation/components/button/custom_button.dart';
import 'package:ibeauty/presentation/components/keyboard_dismisser.dart';
import 'package:ibeauty/presentation/pages/checkout/widget/address_item.dart';
import 'package:ibeauty/presentation/route/app_route.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';

class AddressListService extends StatelessWidget {
  final CustomColorSet colors;
  final ScrollController controller;
  final int? serviceId;
  final MasterModel? master;

  const AddressListService(
      {super.key,
      required this.colors,
      required this.controller,
      required this.serviceId,
      required this.master});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      isLtr: LocalStorage.getLangLtr(),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 400,
        decoration: BoxDecoration(
          color: colors.newBoxColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.r),
            topLeft: Radius.circular(24.r),
          ),
        ),
        padding: EdgeInsets.only(
          left: 16.r,
          right: 16.r,
        ),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return ListView(
              controller: controller,
              children: [
                8.verticalSpace,
                Container(
                  height: 4.r,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width / 2 - 48.r),
                  decoration: BoxDecoration(
                      color: colors.icon,
                      borderRadius: BorderRadius.circular(100.r)),
                ),
                16.verticalSpace,
                Text(
                  AppHelper.getTrn(TrKeys.addressList),
                  style: CustomStyle.interNoSemi(
                      color: colors.textBlack, size: 22),
                ),
                24.verticalSpace,
                if (state.address.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        AppHelper.getTrn(TrKeys.addressBilling),
                        style: CustomStyle.interNormal(
                          color: colors.textBlack,
                        ),
                      ),
                      const Spacer(),
                      ButtonEffectAnimation(
                        onTap: () async {
                          await AppRoute.goAddEditAddress(context: context);
                          if (context.mounted) {
                            context.read<CheckoutBloc>().add(
                                CheckoutEvent.fetchUserAddress(
                                    context: context, isRefresh: true));
                          }
                        },
                        child: Text(
                          AppHelper.getTrn(TrKeys.addAddress),
                          style: CustomStyle.interRegular(
                              color: colors.primary, size: 14),
                        ),
                      ),
                    ],
                  ),
                24.verticalSpace,
                if (state.address.isEmpty)
                  Column(
                    children: [
                      Text(
                        AppHelper.getTrn(TrKeys.thereAreNoYourDelivery),
                        style: CustomStyle.interNoSemi(
                            color: colors.textBlack, size: 16),
                        textAlign: TextAlign.center,
                      ),
                      16.verticalSpace,
                      CustomButton(
                          title: AppHelper.getTrn(TrKeys.addAddress),
                          bgColor: colors.primary,
                          titleColor: colors.white,
                          onTap: () async {
                            if (LocalStorage.getToken().isNotEmpty) {
                              await AppRoute.goAddEditAddress(context: context);
                              if (context.mounted) {
                                context.read<CheckoutBloc>().add(
                                    CheckoutEvent.fetchUserAddress(
                                        context: context, isRefresh: true));
                              }
                            } else {
                              await AppRoute.goLogin(context);
                            }
                          })
                    ],
                  ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.address.length,
                    itemBuilder: (context, index) {
                      return AddressItem(
                        colors: colors,
                        address: state.address[index],
                        active: state.selectAddress == index,
                        onTap: () {
                          context
                              .read<CheckoutBloc>()
                              .add(CheckoutEvent.selectAddress(index: index));

                          context
                              .read<BookingBloc>()
                              .add(BookingEvent.selectMaster(
                                serviceId: serviceId,
                                master: master?.copyWith(
                                  address:
                                      state.address[index].location?.address ??
                                          "",
                                  lat: double.parse(
                                      state.address[index].location?.latitude ??
                                          "0"),
                                  long: double.parse(state
                                          .address[index].location?.longitude ??
                                      "0"),
                                ),
                              ));
                          Navigator.pop(context);
                        },
                        delete: () {
                          context
                              .read<CheckoutBloc>()
                              .add(CheckoutEvent.deleteAddress(
                                index: index,
                                context: context,
                                addressId: state.address[index].id ?? 0,
                              ));
                        },
                        edit: () async {
                          await AppRoute.goAddEditAddress(
                              context: context, address: state.address[index]);
                          if (context.mounted) {
                            context.read<CheckoutBloc>().add(
                                CheckoutEvent.fetchUserAddress(
                                    context: context, isRefresh: true));
                          }
                        },
                      );
                    }),
                16.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
