import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/routes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu/src/config/theme/colorManger.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example course data
    final courses = [
      {
        'title': 'Programming',
        'desc': 'Learn bla blaaa blaa blaaa',
        'lecturer': 'Dr. Abeer Amer',
        'color': const Color(0xFFE7E3FF),
        'icon': Icons.code,
      },
      {
        'title': 'Database',
        'desc': 'Learn bla blaaa blaa blaaa',
        'lecturer': 'Dr. Yasser Abdelghafar',
        'color': const Color(0xFFFFF0E3),
        'icon': Icons.storage,
      },
      {
        'title': 'MOT',
        'desc': 'Learn bla blaaa blaa blaaa',
        'lecturer': 'Dr. Ghada Elkahayat',
        'color': const Color(0xFFE8F7EA),
        'icon': Icons.lightbulb_outline,
      },
      {
        'title': 'System Analysis & Design',
        'desc': 'Learn bla blaaa blaa blaaa',
        'lecturer': 'Dr. Abeer Amer',
        'color': const Color(0xFFE8F7EA),
        'icon': Icons.analytics,
      },
      {
        'title': 'Statistics',
        'desc': 'Learn bla blaaa blaa blaaa',
        'lecturer': 'Dr. Yasser Abdelghafar',
        'color': const Color(0xFFFFF8E3),
        'icon': Icons.bar_chart,
      },
    ];

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.1,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return InkWell(
              onTap: () {
                context.goTo(Routes.courseRoute);
              },
              child: CourseCard(
                title: course['title'].toString(),
                desc: course['desc'].toString(),
                lecturer: course['lecturer'].toString(),
                color: course['color'] as Color,
                icon: course['icon'] as IconData,
              ),
            );
          },
        ),
      ),
    ));
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String desc;
  final String lecturer;
  final Color color;
  final IconData icon;

  const CourseCard({
    super.key,
    required this.title,
    required this.desc,
    required this.lecturer,
    required this.color,
    required this.icon,
  });

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Lec: $lecturer',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(icon, color: ColorsManager.primaryColor, size: 22.sp),
            ],
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              title,
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
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const Spacer(),
          Text(
            lecturer,
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
