import 'package:flutter/material.dart';
import 'package:ibeauty/domain/service/helper.dart';
import 'package:ibeauty/domain/service/tr_keys.dart';
import 'package:ibeauty/presentation/style/style.dart';
import 'package:ibeauty/presentation/style/theme/theme.dart';
import 'package:readmore/readmore.dart';
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart';

class CustomReadMoreText extends StatelessWidget {
  final CustomColorSet colors;
  final String? description;
  final int trimLines;
  final TextStyle? style;

  const CustomReadMoreText(this.description, {
    super.key,
    required this.colors,
    this.trimLines = 3,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      '${parse(description ?? "").body?.text ?? ''} ',
      trimLines: trimLines,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppHelper.getTrn(TrKeys.showMore),
      trimExpandedText: AppHelper.getTrn(TrKeys.showLess),
      lessStyle: CustomStyle.interRegular(
          color: colors.textBlack,
          size: 14,
          textDecoration: TextDecoration.underline),
      moreStyle: CustomStyle.interRegular(
          color: colors.textBlack,
          size: 14,
          textDecoration: TextDecoration.underline),
      style:
      style ?? CustomStyle.interRegular(color: colors.textBlack, size: 14),
    );
  }
}
