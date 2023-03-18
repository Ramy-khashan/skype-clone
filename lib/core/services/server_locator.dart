import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:skype/core/api/dio_consumer.dart';
import 'package:skype/core/repository/app_repository/app_repository_impl.dart';
import 'package:skype/core/repository/sign_up_repository/sign_up_repository_impl.dart';

import '../repository/chats_repository/chats_repository_impl.dart';
import '../repository/profile_repository/profile_repository_impl.dart';
import '../repository/search_repository/search_repository_impl.dart';
import '../repository/sign_in_repository/sign_in_repository_impl.dart';
import '../repository/user_chat_repository/user_chat_repository_impl.dart';

final sl = GetIt.instance;
Future<void> serverLocator() async {
  sl.registerSingleton<DioConsumer>(DioConsumer(client: Dio()));
  sl.registerSingleton<SignUpRepositoryImpl>(SignUpRepositoryImpl(
    dio: sl.get<DioConsumer>(),
  ));
  sl.registerSingleton<ChatRepositoryImpl>(ChatRepositoryImpl());
  sl.registerSingleton<SignInRepositoryImpl>(SignInRepositoryImpl(
    dio: sl.get<DioConsumer>(),
  ));
  sl.registerSingleton<AppRepositoryImpl>(AppRepositoryImpl(
      // dio: sl.get<DioConsumer>(),
      ));
  sl.registerSingleton<ProfileRepositoryImpl>(ProfileRepositoryImpl(
      // dio: sl.get<DioConsumer>(),
      ));
  sl.registerSingleton<SearchRepositoryImpl>(SearchRepositoryImpl(
      // dio: sl.get<DioConsumer>(),
      ));  sl.registerSingleton<UserChatRepositoryImpl>(UserChatRepositoryImpl(
      // dio: sl.get<DioConsumer>(),
      ));
}
