import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Lecture',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.menu_book_outlined,
        'color': const Color(0xFFB9B5FF),
        'border': const Color(0xFF7C7CFF),
      },
      {
        'title': 'Section',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.receipt_long_outlined,
        'color': const Color(0xFFFFE5D1),
        'border': const Color(0xFFFFB385),
      },
      {
        'title': 'Assignment',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.event_note_outlined,
        'color': const Color(0xFFD7FFE6),
        'border': const Color(0xFF43E58B),
      },
      {
        'title': 'Quiz',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.quiz_outlined,
        'color': const Color(0xFFFFF3D1),
        'border': const Color(0xFFFFD85C),
      },
      {
        'title': 'Project',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.insert_chart_outlined,
        'color': const Color(0xFFD7FFE6),
        'border': const Color(0xFF43E58B),
      },
      {
        'title': 'Chat',
        'subtitle': 'bla blaa blaaa blaaa',
        'icon': Icons.chat_outlined,
        'color': const Color(0xFFB9B5FF),
        'border': const Color(0xFF7C7CFF),
      },
    ];
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
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
          itemCount: sections.length,
          separatorBuilder: (_, __) => SizedBox(height: 18.h),
          itemBuilder: (context, index) {
            final section = sections[index];
            return SectionCard(
              title: section['title'] as String,
              subtitle: section['subtitle'] as String,
              icon: section['icon'] as IconData,
              color: section['color'] as Color,
              borderColor: section['border'] as Color,
              items: [
                'Item 1 for ${section['title']}',
                'Item 2 for ${section['title']}',
                'Item 3 for ${section['title']}',
              ],
            );
          },
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color borderColor;
  final List<String> items;

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
          tilePadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 18.w),
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
          children: items
              .map<Widget>((item) => Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 18.w),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.grey),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
