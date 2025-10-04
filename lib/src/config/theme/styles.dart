import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/font_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle font24BlackBold = defaultTextStyle(
  fontSize: 24.sp,
  fontWeight: FontWeightManager.bold,
  color: ColorsManager.black,
);

TextStyle font16BlackBold = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.bold,
  color: ColorsManager.black,
);
TextStyle font16BlackRegular = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.regular,
  color: ColorsManager.black,
);

TextStyle font16Greyregular = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.regular,
  color: ColorsManager.grey,
);
TextStyle font16WhiteBold = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.bold,
  color: Colors.white,
);
TextStyle font24GreyBold = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.bold,
  color: ColorsManager.grey,
);
TextStyle font16Purpleregular = defaultTextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeightManager.bold,
  color: ColorsManager.primaryColor,
);
TextStyle defaultTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
}) {
  return TextStyle(
    fontFamily: FontConstants.fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
