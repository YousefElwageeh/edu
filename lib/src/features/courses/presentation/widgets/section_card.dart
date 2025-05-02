import 'dart:developer';

import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/app%20states/app_states.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/data/models/leactures.dart';
import 'package:edu/src/features/courses/data/models/project_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/courses/presentation/pages/project_screen.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionCard<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color borderColor;
  final List<T> items;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.borderColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(6, 6),
              ),
            ],
            border: Border.all(color: borderColor.withOpacity(0.2), width: 2),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding:
                  EdgeInsets.symmetric(vertical: 4.h, horizontal: 18.w),
              leading: Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(10.w),
                child: Icon(icon, color: borderColor, size: 28.sp),
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              children: items.indexed.map<Widget>((item) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 18.w),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.grey),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (title == 'Quiz') {
                              final quiz = context
                                  .read<CoursesCubit>()
                                  .quizes
                                  .firstWhere((e) => e == item.$2);
                              if (!quiz.isFinished) {
                                context.goTo(Routes.quizRoute, arguments: quiz);
                              } else {
                                AppStates.ErrorToast("Quiz already submitted");
                              }
                            } else if (title == 'Project') {
                              final project = context
                                  .read<CoursesCubit>()
                                  .projects
                                  .firstWhere((e) => e == item.$2);
                              if (!project.isFinished) {
                                context.goTo(Routes.projectRoute,
                                    arguments: ProjectScreen(
                                      isAssignment: false,
                                      cubit: context.read<CoursesCubit>(),
                                      assignment: Assignment(
                                        assignId: project.activityId,
                                        assignTitle: project.activityTitle,
                                        assignDescription:
                                            project.activityDescription,
                                        assignDuedate: project.activityDuedate,
                                        instructorId: project.instructorId,
                                      ),
                                    ));
                              } else {
                                AppStates.ErrorToast(
                                    "Assignment already submitted");
                              }
                            } else if (title == 'Section') {
                              Session? leacture = context
                                  .read<CoursesCubit>()
                                  .sectionsMaterial
                                  .course
                                  ?.session
                                  ?.firstWhere((e) => e == item.$2);

                              log(leacture?.sessionFilePath.toString() ?? "");
                              launchUrl(
                                Uri.parse("${leacture?.sessionFilePath}"),
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            } else if (title == 'Lecture') {
                              Session? leacture = context
                                  .read<CoursesCubit>()
                                  .leactures
                                  .course
                                  ?.session
                                  ?.firstWhere((element) => element == item.$2);
                              launchUrl(
                                Uri.parse("${leacture?.sessionFilePath}"),
                                mode: LaunchMode.externalNonBrowserApplication,
                              );
                            } else if (title == 'Assignment') {
                              Assignment? assignment = context
                                  .read<CoursesCubit>()
                                  .assignments
                                  .firstWhere((e) => e == item.$2);
                              if (!assignment.isFinished) {
                                context.goTo(Routes.projectRoute,
                                    arguments: ProjectScreen(
                                      assignment: assignment,
                                      isAssignment: true,
                                      cubit: context.read<CoursesCubit>(),
                                    ));
                              } else {
                                AppStates.ErrorToast(
                                    "Assignment already submitted");
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "$title ${item.$1 + 1}",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: ColorsManager.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              if (item.$2 is Quizes &&
                                  (item.$2 as Quizes).isFinished)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              if (item.$2 is Projects &&
                                  (item.$2 as Projects).isFinished)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              if (item.$2 is Assignment &&
                                  (item.$2 as Assignment).isFinished)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
