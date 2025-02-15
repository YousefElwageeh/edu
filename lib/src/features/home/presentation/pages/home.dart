import 'package:edu/main.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/config/utils/AppStrings.dart';
import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 15,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.goodMorning,
                          style: font16BlackBold.copyWith(
                              color: ColorsManager.primaryColor),
                        ),
                        verticalSpace(15),
                        Text(
                          AppStrings.haveANiceDay,
                          style: font16Greyregular.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    AssetsManger.lazy_female,
                    height: 100.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ),
          verticalSpace(25),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.weeklyDeadline,
              style:
                  font16BlackBold.copyWith(color: ColorsManager.primaryColor),
            ),
          ),
          verticalSpace(10),
          Expanded(
           
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      "MOT",
                      style: font16BlackBold.copyWith(
                          color: ColorsManager.primaryColor),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 100.h,
                          width: 150.w,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor,
                            borderRadius:  BorderRadius.circular(15.0),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Assigments',
                              style: font16WhiteBold,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'OCT Sunday',
                                  style: font16BlackRegular.copyWith(
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.calendar_today,
                                    color: Colors.white),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          // Row(
          //   children: [
          //     Stack(
          //       alignment: Alignment.bottomLeft,
          //       children: [
          //         Container(
          //           height: 100.h,
          //           width: 140.w,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(
          //                   12), // Optional rounded corners

          //               color: Colors.white,
          //               border: Border(
          //                 top: BorderSide(
          //                     color: ColorsManager.primaryColor, width: 4),
          //                 left: BorderSide(
          //                     color: ColorsManager.primaryColor, width: 4),
          //                 right: BorderSide(
          //                     color: ColorsManager.primaryColor, width: 4),
          //               )),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 5),
          //           child: Container(
          //             width: 100.w,
          //             height: 4,
          //             decoration: BoxDecoration(
          //               color: ColorsManager.primaryColor,
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     // Stack(
          //     //   alignment: Alignment.topRight,
          //     //   children: [
          //     //     Container(
          //     //       height: 100.h,
          //     //       width: 140.w,
          //     //       decoration: BoxDecoration(
          //     //           borderRadius: BorderRadius.circular(
          //     //               12), // Optional rounded corners

          //     //           color: Colors.white,
          //     //           border: Border(
          //     //             bottom: BorderSide(
          //     //                 color: ColorsManager.primaryColor, width: 4),
          //     //             right: BorderSide(
          //     //                 color: ColorsManager.primaryColor, width: 4),
          //     //           )),
          //     //     ),
          //     //     Padding(
          //     //       padding: const EdgeInsets.only(right: 5),
          //     //       child: Container(
          //     //         width: 100.w,
          //     //         height: 4,
          //     //         decoration: BoxDecoration(
          //     //           color: ColorsManager.primaryColor,
          //     //           borderRadius: BorderRadius.circular(12),
          //     //         ),
          //     //       ),
          //     //     ),
          //     //   ],
          //     // ),
          //   ],
          // )
        ],
      ),
    );
  }
}
