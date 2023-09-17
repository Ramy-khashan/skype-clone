import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/app_controller/appcontrorller_cubit.dart';
import 'core/repository/sign_up_repository/sign_up_repository_impl.dart';
import 'core/services/server_locator.dart';
import 'core/utils/app_color.dart';
import 'core/utils/app_strings.dart';
import 'modules/sign_up/controller/sign_up_cubit.dart';
import 'modules/splash_screen/view/view.dart';
import 'core/repository/sign_in_repository/sign_in_repository_impl.dart';
import 'modules/sign_in/controller/sign_in_cubit.dart';

class SkypeApp extends StatelessWidget {
  const SkypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpRepositoryImpl: sl.get<SignUpRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) => AppcontrorllerCubit()..savedTheme(),
        ),
        BlocProvider(
          create: (context) =>
              SignUpCubit(signUpRepositoryImpl: sl.get<SignUpRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              SignInCubit(signInRepositoryImpl: sl.get<SignInRepositoryImpl>())..getToken(),
        )
      ],
      child: BlocBuilder<AppcontrorllerCubit, AppcontrorllerState>(
        builder: (context, state) {
          final controller = AppcontrorllerCubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppString.title,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                cardColor: Colors.grey.shade700,
                useMaterial3: true,
              ),
              themeMode: controller.themeMode,
              theme: ThemeData(
                iconTheme: const IconThemeData(color: Colors.white),
                appBarTheme: const AppBarTheme(elevation: 4),
                primaryColor: AppColor.primary,
                scaffoldBackgroundColor: Colors.grey.shade300,
                cardColor: Colors.grey.shade700,
                useMaterial3: true,
              ),
              home: const SplashScreen());
        },
      ),
    );
  }
}
