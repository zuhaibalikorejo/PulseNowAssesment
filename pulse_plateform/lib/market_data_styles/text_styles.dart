

import 'package:flutter/material.dart';
import 'package:pulse_plateform/core/common/core_app_colors.dart';
import 'package:pulse_plateform/market_data_styles/style_constants.dart';


abstract class TextStyles {
  TextStyles._();

  /*--------------------------------Graphic Styles------------------------*/


  static final TextStyle textStyleCIRStdRegular = TextStyle(
    color: CoreAppColors.color222325,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.33,
    fontFamily: StyleConstant.circularStdRegularFontFamily,
  );



  static final TextStyle textStyleCIRStdMedium = TextStyle(
    color: CoreAppColors.color222325,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.33,
    fontFamily: StyleConstant.circularStdMediumFontFamily,
  );

}
