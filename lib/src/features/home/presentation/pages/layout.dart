import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edu/di.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/calender/presentation/pages/calender_screen.dart';
import 'package:edu/src/features/chat/presentation/pages/chat_screen.dart';
import 'package:edu/src/features/chat/presentation/widgets/chat_list.dart';
import 'package:edu/src/features/courses/presentation/pages/course_screen.dart';
import 'package:edu/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:edu/src/features/home/presentation/pages/home.dart';
import 'package:edu/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:edu/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        color: ColorsManager.primaryColor,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.calendar_month,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          selectedIndex = index;
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
      ),
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              selectedIndex = value;
              setState(() {});
            },
            controller: pageController,
            children: [
              BlocProvider(
                create: (context) => HomeCubit(
                  repository: di(),
                ),
                child: const HomeScreen(),
              ),
              const CourseScreen(),
              const CalendarScreen(),
              const ChatScreen(),
              BlocProvider(
                create: (context) => HomeCubit(
                  repository: di(),
                )..getStudentData(),
                child: BlocProvider(
                  create: (context) => ProfileCubit(),
                  child: const ProfileScreen(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
