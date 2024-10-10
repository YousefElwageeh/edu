import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        AssetsManger.logo,
        height: 70,
        width: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
