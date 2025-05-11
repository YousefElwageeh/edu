import 'dart:developer' as dev;

import 'package:edu/di.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/data/models/answers_model.dart';
import 'package:edu/src/features/courses/data/models/quizes.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/courses/presentation/widgets/section_card.dart';
import 'package:edu/src/features/home/data/models/weekly_dead_lines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:no_screenshot/no_screenshot.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseName;
  final int courseId;
  final CoursesCubit cubit;

  const CourseDetailsScreen({
    super.key,
    required this.courseName,
    required this.courseId,
    required this.cubit,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool result = await _noScreenshot.screenshotOn();
      debugPrint('Screenshot On: $result');
      context.read<CoursesCubit>().getQuizes(widget.courseId.toString());
      context.read<CoursesCubit>().getLectures(widget.courseId);
      context.read<CoursesCubit>().getSections(widget.courseId);
      context.read<CoursesCubit>().getAssignments(widget.courseId);
      context.read<CoursesCubit>().getProjects(widget.courseId);
    });
    // Load course data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  spacing: 15,
                  children: [
                    SectionCard<dynamic>(
                        title: context.read<CoursesCubit>().sections[0]['title']
                            as String,
                        subtitle: context.read<CoursesCubit>().sections[0]
                            ['subtitle'] as String,
                        icon: context.read<CoursesCubit>().sections[0]['icon']
                            as IconData,
                        color: context.read<CoursesCubit>().sections[0]['color']
                            as Color,
                        borderColor: context.read<CoursesCubit>().sections[0]
                            ['border'] as Color,
                        items: context
                                .read<CoursesCubit>()
                                .leactures
                                .course
                                ?.session ??
                            []),
                    SectionCard<dynamic>(
                        title: context.read<CoursesCubit>().sections[1]['title']
                            as String,
                        subtitle: context.read<CoursesCubit>().sections[1]
                            ['subtitle'] as String,
                        icon: context.read<CoursesCubit>().sections[1]['icon']
                            as IconData,
                        color: context.read<CoursesCubit>().sections[1]['color']
                            as Color,
                        borderColor: context.read<CoursesCubit>().sections[1]
                            ['border'] as Color,
                        items: context
                                .read<CoursesCubit>()
                                .sectionsMaterial
                                .course
                                ?.session ??
                            []),
                    SectionCard<Assignment>(
                      title: context.read<CoursesCubit>().sections[2]['title']
                          as String,
                      subtitle: context.read<CoursesCubit>().sections[2]
                          ['subtitle'] as String,
                      icon: context.read<CoursesCubit>().sections[2]['icon']
                          as IconData,
                      color: context.read<CoursesCubit>().sections[2]['color']
                          as Color,
                      borderColor: context.read<CoursesCubit>().sections[2]
                          ['border'] as Color,
                      items: context.read<CoursesCubit>().assignments,
                    ),
                    SectionCard<Quizes>(
                      title: context.read<CoursesCubit>().sections[3]['title']
                          as String,
                      subtitle: context.read<CoursesCubit>().sections[3]
                          ['subtitle'] as String,
                      icon: context.read<CoursesCubit>().sections[3]['icon']
                          as IconData,
                      color: context.read<CoursesCubit>().sections[3]['color']
                          as Color,
                      borderColor: context.read<CoursesCubit>().sections[3]
                          ['border'] as Color,
                      items: context.read<CoursesCubit>().quizes,
                    ),
                    SectionCard<dynamic>(
                      title: context.read<CoursesCubit>().sections[4]['title']
                          as String,
                      subtitle: context.read<CoursesCubit>().sections[4]
                          ['subtitle'] as String,
                      icon: context.read<CoursesCubit>().sections[4]['icon']
                          as IconData,
                      color: context.read<CoursesCubit>().sections[4]['color']
                          as Color,
                      borderColor: context.read<CoursesCubit>().sections[4]
                          ['border'] as Color,
                      items: context.read<CoursesCubit>().projects,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
