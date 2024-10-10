import 'package:edu/src/features/authntcation/presentation/pages/login.dart';
import 'package:edu/src/features/authntcation/presentation/pages/register.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String loginScreen = '/loginScreen';
  static const String register = '/registerScreen';
}

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
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
