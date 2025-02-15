import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edu/src/config/theme/colorManger.dart';
import 'package:edu/src/features/home/presentation/pages/home.dart';
import 'package:edu/src/features/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
          selectedIndex = value;
          setState(() {});
          },
            controller: pageController,
          children: const [HomeScreen(), SizedBox(), SizedBox(), SizedBox(),ProfileScreen()],
        ),
      ),
    );
  }
}
