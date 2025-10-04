import 'dart:math';

import 'package:edu/di.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/courses/presentation/pages/course_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  void initState() {
    super.initState();
    preCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit(di())..getCourses(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CoursesCubit, CoursesState>(
            builder: (context, state) {
              if (state is CoursesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CoursesError) {
                return Center(child: Text(state.message));
              } else {
                final courses = context.read<CoursesCubit>().courses;
                if (courses.isEmpty) {
                  return const Center(child: Text('No courses available'));
                }
                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 1,
                    ),
                    itemCount: courses.length > 10 ? 10 : courses.length,
                    itemBuilder: (context, index) {
                      final courseData = courses[index];
                      if (courseData.course == null) return const SizedBox();

                      return InkWell(
                        onTap: () {
                          context.goTo(Routes.courseRoute,
                              arguments: CourseDetailsScreen(
                                courseId: courseData.course?.courseId ?? 0,
                                courseName: courseData.course?.courseName ?? '',
                                cubit: context.read<CoursesCubit>(),
                              ));
                        },
                        child: CourseCard(
                          title: courseData.course?.courseName ?? '',
                          desc: courseData.course?.courseDescription ?? '',
                          lecturer:
                              courseData.instructor?.instructorName ?? 'N/A',
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox(); // Initial state
            },
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String desc;
  final String lecturer;
  final Color color;
  final IconData icon;

  CourseCard({
    super.key,
    required this.title,
    required this.desc,
    required this.lecturer,
  })  : color = coursesColors[Random().nextInt(coursesColors.length)],
        icon = coursesIcons[Random().nextInt(coursesIcons.length)];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Text(
              //     'Lec: $lecturer',
              //     style: TextStyle(
              //       fontSize: 10.sp,
              //       color: Colors.black54,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              Icon(icon, color: ColorsManager.primaryColor, size: 22.sp),
            ],
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              desc,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Dr. $lecturer",
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

final coursesColors = [
  const Color(0xFFE7E3FF),
  const Color(0xFFFFF0E3),
  const Color(0xFFE8F7EA),
  const Color(0xFFE8F7EA),
  const Color(0xFFFFF8E3),
];
final coursesIcons = [
  Icons.code,
  Icons.storage,
  Icons.lightbulb_outline,
  Icons.analytics,
  Icons.bar_chart,
];
