// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppStates {
  static Widget LodaingState() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
          child: CircularProgressIndicator(
        color: ColorsManager.primaryColor,
      )),
    );
  }

  static ErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static SucessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

// ignore: must_be_immutable
// class ErrorScreen extends StatelessWidget {
//   void Function() onPressed;

//   ErrorScreen({
//     Key? key,
//     required this.onPressed,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Oops Some thing Went Wrong please try again'),
//             CustomButton(text: 'try again', onPressed: onPressed)
//           ],
//         ),
//       ),
//     );
//   }
// }
