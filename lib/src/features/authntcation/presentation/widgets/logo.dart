import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart' as Styles;
import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SvgPicture.asset(
            AssetsManger.logo,
            height: 70,
            width: 100,
            colorFilter: ColorFilter.mode(
              ColorsManager.primaryColor,
              BlendMode.srcIn,
            ),
            fit: BoxFit.contain,
          ),
          Text(
            'Cortexa',
            style: Styles.font24BlackBold.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
