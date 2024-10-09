// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class AppStates {
  // static ErrorState(message) {
  //   return Get.snackbar('Error', message,
  //       snackPosition: SnackPosition.TOP,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white);
  // }

  // static SucessState(message) {
  //   return message == ''
  //       ? null
  //       : Get.snackbar('Sucess', message,
  //           snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.green,
  //           colorText: Colors.white);
  // }

  static Widget LodaingState() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
          child: CircularProgressIndicator(
        color: ColorsManager.primaryColor,
      )),
    );
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
