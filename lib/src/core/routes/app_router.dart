import 'package:edu/di.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/features/authntcation/data/repositories/login_repo.dart';
import 'package:edu/src/features/authntcation/presentation/pages/login.dart';
import 'package:edu/src/features/authntcation/presentation/cubit/authntcation_cubit.dart';
import 'package:edu/src/features/authntcation/presentation/pages/register.dart';
import 'package:edu/src/features/courses/presentation/pages/course_details_screen.dart';
import 'package:edu/src/features/courses/presentation/pages/project_screen.dart';
import 'package:edu/src/features/courses/presentation/pages/quiz_screen.dart';
import 'package:edu/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:edu/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:edu/src/features/home/presentation/pages/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String layoutRoute = '/layout';
  static const String courseRoute = '/course';
  static const String quizRoute = '/quiz';
  static const String projectRoute = '/project';
}

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.projectRoute:
        return MaterialPageRoute(
          builder: (_) => const ProjectScreen(),
        );
      case Routes.quizRoute:
        return MaterialPageRoute(
          builder: (_) => const QuizScreen(),
        );
      case Routes.courseRoute:
        return MaterialPageRoute(
          builder: (_) => const CourseDetailsScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) {
            preAuth();
            return BlocProvider(
              create: (context) => AuthntcationCubit(
                repository: di<LoginRepository>(),
              ),
              child: LoginScreen(),
            );
          },
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
