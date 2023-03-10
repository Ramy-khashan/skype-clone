import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skype/core/api/dio_consumer.dart';
import 'package:skype/core/repository/sign_up_repository/sign_up_repository_impl.dart';

import '../repository/sign_in_repository/sign_in_repository_impl.dart';

final sl = GetIt.instance;
Future<void> serverLocator() async {
  sl.registerSingleton<DioConsumer>(DioConsumer(client: Dio()));
  sl.registerSingleton<SignUpRepositoryImpl>(SignUpRepositoryImpl(
    dio: sl.get<DioConsumer>(),
  ));sl.registerSingleton<SignInRepositoryImpl>(SignInRepositoryImpl(
    dio: sl.get<DioConsumer>(),
  ));
}
