import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/application/service/service_bloc.dart';
import 'package:ibeauty/domain/model/model/master_model.dart';
import 'package:ibeauty/domain/model/model/service_extra.dart';
import 'package:ibeauty/domain/model/model/service_model.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/presentation/components/button/animation_button_effect.dart';
import 'package:ibeauty/presentation/route/app_route_service.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';

class ServiceItem extends StatelessWidget {
  final CustomColorSet colors;
  final ServiceModel service;
  final List<ServiceExtra>? extras;
  final bool bookButton;
  final bool booked;
  final int? shopId;
  final MasterModel? master;

  const ServiceItem(
      {super.key,
      required this.colors,
      required this.service,
      this.bookButton = true,
      this.shopId,
      this.booked = false,
      this.master,
      this.extras});

  @override
  Widget build(BuildContext context) {
    num price = service.price ?? 0;
    extras?.forEach((e) => price += e.price ?? 0);
    return InkWell(
      onTap: () {
        AppRouteService.goServiceBottomSheet(
          context: context,
          service: service,
          extras: extras,
          colors: colors,
          bookButton: bookButton,
          shopId: shopId,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          24.verticalSpace,
          const Divider(),
          16.verticalSpace,
          Row(
            children: [
              Text(
                service.translation?.title ?? "",
                style:
                    CustomStyle.interNoSemi(color: colors.textBlack, size: 18),
              ),
              4.horizontalSpace,
              if (service.faqs?.isNotEmpty ?? false)
                ButtonEffectAnimation(
                  onTap: () {
                    AppHelper.showCustomDialog(
                        context: context,
                        content: Container(
                          padding: REdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: colors.backgroundColor,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppHelper.getTrn(TrKeys.faqs),
                                        style: CustomStyle.interNoSemi(
                                            color: colors.textBlack, size: 18),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        FlutterRemix.close_circle_line,
                                        size: 24.r,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                                4.verticalSpace,
                                ...?service.faqs?.map(
                                  (e) => Padding(
                                    padding: REdgeInsets.only(bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.translation?.question ?? '',
                                          textAlign: TextAlign.center,
                                          style: CustomStyle.interNoSemi(
                                            color: colors.textBlack,
                                            size: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding: REdgeInsets.only(left: 8),
                                          child: Text(
                                            e.translation?.answer ?? '',
                                            textAlign: TextAlign.center,
                                            style: CustomStyle.interNormal(
                                              color: colors.textBlack,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                  child: Icon(
                    FlutterRemix.question_line,
                    size: 21.r,
                  ),
                )
            ],
          ),
          4.verticalSpace,
          Text(
            service.translation?.description ?? "",
            style: CustomStyle.interRegular(color: colors.textBlack, size: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          8.verticalSpace,
          Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.r, top: 8.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: colors.textHint)),
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                child: Text(
                  "${AppHelper.getTrn(TrKeys.from)} ${AppHelper.numberFormat(number: service.price)}",
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 8.r, top: 8.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: colors.textHint)),
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                child: Text(
                  "${service.interval ?? 0} ${AppHelper.getTrn(TrKeys.minute)}",
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 12),
                ),
              ),
              if (service.type != null)
                Container(
                  margin: EdgeInsets.only(right: 8.r, top: 8.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: colors.textHint)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                  child: Text(
                    AppHelper.getTrn(service.type ?? ""),
                    style: CustomStyle.interNormal(
                        color: colors.textHint, size: 12),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(right: 8.r, top: 8.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: colors.textHint)),
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                child: Text(
                  AppHelper.getTrn(service.gender == 1
                      ? TrKeys.male
                      : service.gender == 1
                          ? TrKeys.female
                          : TrKeys.both),
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 12),
                ),
              )
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppHelper.getTrn(TrKeys.price),
                    style: CustomStyle.interNormal(
                        color: colors.textHint, size: 14),
                  ),
                  Text(
                    AppHelper.numberFormat(number: price),
                    style: CustomStyle.interNoSemi(
                        color: colors.textBlack, size: 22),
                  )
                ],
              ),
              const Spacer(),
              ButtonEffectAnimation(
                onTap: () {
                  if (bookButton) {
                    if (service.extras?.isNotEmpty ?? false) {
                      AppRouteService.goServiceBottomSheet(
                        context: context,
                        service: service,
                        colors: colors,
                        bookButton: bookButton,
                        shopId: shopId,
                        extras: extras,
                      );
                    } else {
                      context
                          .read<ServiceBloc>()
                          .add(ServiceEvent.selectService(service: service));
                    }
                    return;
                  }
                  AppRouteService.goServiceListPage(
                      context: context, shopId: shopId);
                },
                child: bookButton
                    ? Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                            color: booked ? colors.primary : colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: booked
                                    ? colors.primary
                                    : colors.textBlack)),
                        child: Center(
                          child: Icon(
                            booked
                                ? FlutterRemix.check_fill
                                : FlutterRemix.add_fill,
                            color: booked ? colors.textWhite : colors.textBlack,
                          ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.r, horizontal: 16.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: colors.textBlack)),
                        child: Text(
                          AppHelper.getTrn(TrKeys.book),
                          style: CustomStyle.interNormal(
                              color: colors.textBlack, size: 16),
                        ),
                      ),
              ),
            ],
          ),
          8.verticalSpace,
        ],
      ),
    );
  }
}
