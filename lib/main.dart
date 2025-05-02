import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:edu/bloc_observer.dart';
import 'package:edu/di.dart';
import 'package:edu/src/config/theme/themes.dart';
import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/routes/app_router.dart';
import 'package:edu/src/core/shared_prefrence/shared_prefrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://iuiwdjtmdeempcqxeuhf.supabase.co",
    anonKey: Constants.apiKey,
  );
  final supabaseLogger = Logger('supabase');
  hierarchicalLoggingEnabled = true;
  supabaseLogger.level =
      Level.ALL; // custom log level filtering, default is Level.INFO
  supabaseLogger.onRecord.listen((record) {
    log('${record.level.name}: ${record.time}: ${record.message}');
  });
  await initAppModule();
  Bloc.observer = MyBlocObserver();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

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
