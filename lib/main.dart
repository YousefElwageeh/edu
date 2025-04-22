import 'package:bloc/bloc.dart';
import 'package:edu/bloc_observer.dart';
import 'package:edu/di.dart';
import 'package:edu/src/config/theme/themes.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/shared_prefrence/shared_prefrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  Bloc.observer = MyBlocObserver();

  Constants.studentId =
      await di<FlutterSecureStorage>().read(key: PrefData.token);
  runApp(EDU(
    studentId: Constants.studentId,
  ));
}

class EDU extends StatelessWidget {
  String? studentId;

  EDU({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme(),
          initialRoute:
              studentId != null ? Routes.layoutRoute : Routes.loginRoute,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
