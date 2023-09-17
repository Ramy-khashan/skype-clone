import 'dart:convert';
import 'dart:developer'; 
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/repository/app_repository/app_repository_impl.dart';
import '../../../core/utils/storage_keys.dart';
import '../model/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final AppRepositoryImpl appRepositoryImpl;

  ChatCubit({required this.appRepositoryImpl}) : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
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
  bool isLoadingData = false; 
  getrindUserdata(users) async {
    isLoadingData = true;
    emit(StartGettingFriendDataState());
    userFriendData = await appRepositoryImpl.getFrindsData(friendsId: users);
    log(userFriendData.length.toString());
    isLoadingData = false;
    emit(GetFriendDataState());
  }

 

// Replace with your FCM server key
 
}
