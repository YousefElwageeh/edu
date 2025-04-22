import 'dart:developer';

import 'package:edu/src/core/api/constant&endPoints.dart';
import 'package:edu/src/core/api/dio_factory.dart';
import 'package:edu/src/core/shared_prefrence/shared_prefrence.dart';
import 'package:edu/src/features/authntcation/data/datasources/login_data_source.dart';
import 'package:edu/src/features/authntcation/data/repositories/login_repo.dart';
import 'package:edu/src/features/courses/data/datasources/courses_data_source.dart';
import 'package:edu/src/features/courses/data/repositories/course_repo.dart';
import 'package:edu/src/features/home/data/datasources/home_remote_data_source.dart';
import 'package:edu/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:edu/src/features/profile/data/datasources/profile_data_source.dart';
import 'package:edu/src/features/profile/data/repositories/profile_repo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;
Future<void> initAppModule() async {
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  IOSOptions getIOSOptions() => const IOSOptions();

//init the  FlutterSecureStorage for saving the token securly

  di.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(
        aOptions: getAndroidOptions(), iOptions: getIOSOptions()),
  );
//init the  SharedPreferences for saving the the other data
  Constants.studentId =
      await di<FlutterSecureStorage>().read(key: PrefData.token);

  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  di.registerLazySingleton<PrefData>(
    () => PrefData(di<SharedPreferences>()),
  );

  // di.registerLazySingleton<AppIntercepters>(() => AppIntercepters());
//init dio
  log(Constants.studentId ?? '');
  await DioFactory.getDio();
  di.registerLazySingleton<DioFactory>(() => DioFactory());
}

void preAuth() {
  if (!di.isRegistered<LoginDataSource>()) {
    di.registerLazySingleton<LoginDataSource>(
      () => LoginDataSource(),
    );

    di.registerLazySingleton<LoginRepository>(
      () => LoginRepository(dataSource: di<LoginDataSource>()),
    );
  }
}

preHome() {
  if (!di.isRegistered<HomeRemoteDataSource>()) {
    di.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl());

    di.registerLazySingleton<HomeRepository>(
      () => HomeRepository(
        remoteDataSource: di<HomeRemoteDataSource>(),
      ),
    );
  }
}

preCourses() {
  if (!di.isRegistered<CourseRepo>()) {
    di.registerLazySingleton<CoursesDataSource>(() => CoursesDataSource());
    di.registerLazySingleton<CourseRepo>(
        () => CourseRepo(di<CoursesDataSource>()));
  }
}

preProfile() {
  if (!di.isRegistered<ProfileRepo>()) {
    di.registerLazySingleton<ProfileDataSource>(() => ProfileDataSource());

    di.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(di<ProfileDataSource>()),
    );
  }
}
