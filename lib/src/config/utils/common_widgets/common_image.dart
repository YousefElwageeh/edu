import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class CommonImage extends StatelessWidget {
  String? path;
  double? width;
  double? height;
  BoxFit? fit;
  CommonImage({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path ?? "",
      width: width,
      height: height,
      fit: fit,
    );
  }
}

NetworkImage commonImageProvider(String? path) {
  return NetworkImage(
    path ?? "",
  );
}
