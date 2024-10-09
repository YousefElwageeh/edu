import 'dart:io';

import 'package:flutter/material.dart';
import 'package:edu/src/config/utils/AppStrings.dart';

Dialog exitDialog() {
  return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.exitApp,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(AppStrings.No),
                ),
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text(AppStrings.Yes),
                ),
              ],
            )
          ],
        ),
      ));
}
