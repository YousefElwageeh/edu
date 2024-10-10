import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:flutter/material.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsManger.auth_Image,
      height: 250,
      width: 300,
      fit: BoxFit.contain,
    );
  }
}
