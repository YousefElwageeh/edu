import 'package:edu/src/config/theme/themes.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const EDU());
}

class EDU extends StatelessWidget {
  const EDU({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme(),
          initialRoute: Routes.loginScreen,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
