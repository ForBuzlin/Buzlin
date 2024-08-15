import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibeauty/domain/model/response/booking_response.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/presentation/components/button/custom_button.dart';
import 'package:ibeauty/presentation/route/app_route_service.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';

class BookedServiceItem extends StatelessWidget {
  final CustomColorSet colors;
  final BookingModel bookingModel;
  final int? shopId;

  const BookedServiceItem(
      {super.key,
      required this.colors,
      required this.bookingModel,
      required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              bookingModel.serviceMaster?.service?.translation?.title ?? "",
              style: CustomStyle.interNormal(color: colors.textBlack, size: 20),
            ),
            const Spacer(),
            Text(
              AppHelper.numberFormat(number: bookingModel.price),
              style: CustomStyle.interNoSemi(color: colors.textBlack, size: 18),
            ),
          ],
        ),
        6.verticalSpace,
        Text(
          "${AppHelper.getTrn(TrKeys.time)} : ${bookingModel.serviceMaster?.interval} ${AppHelper.getTrn(TrKeys.minute)} ${AppHelper.getTrn(TrKeys.withKey)} ${bookingModel.master?.firstname}",
          style: CustomStyle.interNormal(color: colors.textHint, size: 14),
        ),
        6.verticalSpace,
        if (bookingModel.extras?.isNotEmpty ?? false)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Padding(
                padding: REdgeInsets.only(bottom: 6),
                child: Text(
                  "${AppHelper.getTrn(TrKeys.extras)} : ",
                  style:
                      CustomStyle.interNormal(color: colors.textHint, size: 14),
                ),
              ),
              ...?bookingModel.extras?.map((e) => Padding(
                    padding: REdgeInsets.only(bottom: 6,right: 4),
                    child: Text(
                      "${e.translation?.title} (+${AppHelper.numberFormat(number: e.price)})",
                      style: CustomStyle.interNormal(
                          color: colors.textHint, size: 14),
                    ),
                  ))
            ],
          ),
        Text(
          "${AppHelper.getTrn(TrKeys.status)} : ${AppHelper.getTrn(bookingModel.status ?? '')}",
          style: CustomStyle.interNormal(color: colors.textHint, size: 14),
        ),
        6.verticalSpace,
        Text(
          "${AppHelper.getTrn(TrKeys.bookingId)} : ${bookingModel.id}",
          style: CustomStyle.interNormal(color: colors.textHint, size: 14),
        ),
        if (bookingModel.address != null)
          Padding(
            padding: EdgeInsets.only(top: 6.r),
            child: Text(
              "${AppHelper.getTrn(TrKeys.address)} : ${bookingModel.address?.address ?? ""}",
              style: CustomStyle.interNormal(color: colors.textHint, size: 14),
            ),
          ),
        if (bookingModel.membership != null)
          Padding(
            padding: EdgeInsets.only(top: 6.r),
            child: Text(
              "${AppHelper.getTrn(TrKeys.membershipId)} : ${bookingModel.membership?.id ?? ""}",
              style: CustomStyle.interNormal(color: colors.textHint, size: 14),
            ),
          ),
        16.verticalSpace,
        if (bookingModel.status == TrKeys.ended)
          Padding(
            padding: EdgeInsets.only(bottom: 16.r),
            child: CustomButton(
                title: AppHelper.getTrn(bookingModel.review == null
                    ? TrKeys.addReview
                    : TrKeys.editReview),
                bgColor: colors.primary,
                titleColor: colors.white,
                onTap: () {
                  AppRouteService.goAddReviewBookingPage(
                      context: context, shopId: shopId, booking: bookingModel);
                }),
          ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.r),
          child: CustomButton(
              title: AppHelper.getTrn(TrKeys.goNotes),
              bgColor: colors.primary,
              titleColor: colors.white,
              onTap: () {
                AppRouteService.goBookingNotesPage(
                    context: context, book: bookingModel);
              }),
        ),
      ],
    );
  }
}
