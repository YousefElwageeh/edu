import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:edu/src/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:edu/src/features/courses/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseName;
  final CoursesCubit cubit;

  const CourseDetailsScreen({
    super.key,
    required this.courseName,
    required this.cubit,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    context.read<CoursesCubit>().getQuizes(widget.courseName);
    super.initState();
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
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
              itemCount: context.read<CoursesCubit>().sections.length,
              separatorBuilder: (_, __) => SizedBox(height: 18.h),
              itemBuilder: (context, index) {
                final section = context.read<CoursesCubit>().sections[index];
                return SectionCard(
                  title: section['title'] as String,
                  subtitle: section['subtitle'] as String,
                  icon: section['icon'] as IconData,
                  color: section['color'] as Color,
                  borderColor: section['border'] as Color,
                  items: section['items'] as List<String>,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
