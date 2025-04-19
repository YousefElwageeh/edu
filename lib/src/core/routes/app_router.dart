import 'package:edu/src/features/authntcation/presentation/pages/login.dart';
import 'package:edu/src/features/authntcation/presentation/pages/register.dart';
import 'package:edu/src/features/courses/presentation/pages/course_details_screen.dart';
import 'package:edu/src/features/home/presentation/pages/layout.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String layoutRoute = '/layout';
  static const String courseRoute = '/course';
}

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.courseRoute:
        return MaterialPageRoute(
          builder: (_) => const CourseDetailsScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case Routes.layoutRoute:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
