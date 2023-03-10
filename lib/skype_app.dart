import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/repository/sign_up_repository/sign_up_repository_impl.dart';
import 'package:skype/core/services/server_locator.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/app_strings.dart';
import 'package:skype/modules/sign_up/controller/sign_up_cubit.dart';

import 'core/repository/sign_in_repository/sign_in_repository_impl.dart';
import 'modules/sign_in/controller/sign_in_cubit.dart';
import 'modules/splash_screen/view/view.dart';

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
          create: (context) =>
              SignInCubit(signInRepositoryImpl: sl.get<SignInRepositoryImpl>()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.title,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
