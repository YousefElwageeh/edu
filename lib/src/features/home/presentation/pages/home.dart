import 'package:edu/di.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/config/theme/styles.dart';
import 'package:edu/src/config/utils/AppStrings.dart';
import 'package:edu/src/config/utils/assetsManger.dart';
import 'package:edu/src/core/helpers/spacing.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:edu/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    preHome();
    context.read<HomeCubit>().getStudentData();
    context.read<HomeCubit>().getWeeklyDeadlines();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return PopScope(
      canPop: false,
      child: Padding(
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
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.goodMorning +
                                    homeCubit.student.studentName,
                                style: font16BlackBold.copyWith(
                                    color: ColorsManager.primaryColor),
                              ),
                              verticalSpace(5),
                              Text(
                                AppStrings.haveANiceDay,
                                style: font16Greyregular.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Image.asset(
                      AssetsManger.auth_Image,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.contain,
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
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: homeCubit.deadlines
                        .expand((deadline) => deadline.course?.assignment ?? [])
                        .length,
                    itemBuilder: (context, index) {
                      final List<Assignment> assignments = homeCubit.deadlines
                          .expand<Assignment>(
                              (deadline) => deadline.course?.assignment ?? [])
                          .toList();
                      final assignment = assignments[index];
                      final courseName = homeCubit.deadlines
                              .firstWhere((deadline) =>
                                  deadline.course?.courseId ==
                                  assignment.courseId)
                              .course
                              ?.courseName ??
                          '';
                      return Column(
                        children: [
                          Text(
                            courseName,
                            style: font16BlackBold.copyWith(
                                color: ColorsManager.primaryColor),
                          ),
                          verticalSpace(10),
                          Container(
                            height: 100.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorsManager.primaryColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    assignment.assignTitle ?? '',
                                    style: font16BlackRegular.copyWith(
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  color: ColorsManager.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${assignment.assignDuedate?.day}/${assignment.assignDuedate?.month}/${assignment.assignDuedate?.year}',
                                        style: font16BlackRegular.copyWith(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.calendar_today,
                                          color: Colors.white, size: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
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
      ),
    );
  }
}
