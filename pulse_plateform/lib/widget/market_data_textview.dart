import 'package:flutter/material.dart';
import 'package:pulse_plateform/market_data_styles/core_app_colors.dart';
import 'package:pulse_plateform/market_data_styles/style_constants.dart';
import 'package:pulse_plateform/market_data_styles/text_styles.dart';


import 'package:pulse_plateform/resources/dimens.dart';

class MarketDataTextView extends Text {
  MarketDataTextView(
    String data, {
    Key? key,
    double fontSize = dimen16,
    bool defaultStyle = false,
    Color color = CoreAppColors.color222325,
    TextStyle? style,
    String font = StyleConstant.circularStdRegularFontFamily,
    TextAlign alignment = TextAlign.start,
    int? maxLines,
    TextOverflow? textOverflow,
  }) : super(
          data,
          style: style ?? TextStyles.textStyleCIRStdRegular,
          key: key,
          textAlign: alignment,
          maxLines: maxLines,
          overflow: textOverflow,
        );
}
