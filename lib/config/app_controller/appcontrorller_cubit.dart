 
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/utils/storage_keys.dart';
part 'appcontrorller_state.dart';

class AppcontrorllerCubit extends Cubit<AppcontrorllerState> {
  AppcontrorllerCubit() : super(AppcontrorllerInitial());
  static AppcontrorllerCubit get(context) => BlocProvider.of(context);
  bool isDark = true;
  ThemeMode themeMode = ThemeMode.light;
  String themeType = '';
  savedTheme() async {
    String? theme =
        await const FlutterSecureStorage().read(key: StorageKeys.theme);
    themeType = theme.toString();
    themeMode = themeType == "dark" ? ThemeMode.dark : ThemeMode.light;
    isDark = themeType == "dark" ? true : false;
    emit(GetValFromSPState());
  }

  changeTheme() async {
    emit(AppcontrorllerInitial());

    isDark = !isDark;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await const FlutterSecureStorage()
        .write(key: StorageKeys.theme, value: isDark ? "dark" : "light");
    emit(ChangeToDarkState());
  }
}
