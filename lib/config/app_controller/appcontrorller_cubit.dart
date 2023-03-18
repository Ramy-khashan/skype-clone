import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skype/core/utils/storage_keys.dart';

import '../../core/repository/app_repository/app_repository_impl.dart';
import '../../modules/chats/model/user_model.dart';

part 'appcontrorller_state.dart';

class AppcontrorllerCubit extends Cubit<AppcontrorllerState> {
  final AppRepositoryImpl appRepositoryImpl;

  AppcontrorllerCubit({required this.appRepositoryImpl})
      : super(AppcontrorllerInitial());
  static AppcontrorllerCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  bool isLoadingData = false;
  getUserdata() async {
    userModel = await appRepositoryImpl.onGetUserSavedData();
    emit(GetUserDataState());
  }

  List userFriend = [];
  List<UserModel> userFriendData = [];
  friends(users) {
    userFriend = users;
    getrindUserdata(users);
    emit(GetUserFrindsState());
  }

  getFrinds() async {
    if (await const FlutterSecureStorage().read(key: StorageKeys.userUid) !=
        null) {
      final frinds = await appRepositoryImpl.getFrindsIds();
      friends(frinds);
    
    }
  }

  bool  isLoaingFrindData = false;
  getrindUserdata(users) async {
    isLoadingData = true;
    emit(StartGettingFriendDataState());
    userFriendData = await appRepositoryImpl.getFrindsData(friendsId: users);
    log(userFriendData.length);
    isLoadingData = false;
    emit(GetFriendDataState());
  }
}
