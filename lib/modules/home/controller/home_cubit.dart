 

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../../core/repository/app_repository/app_repository_impl.dart';
import '../../../core/utils/app_color.dart'; 
import '../../chats/model/user_model.dart'; 
import '../../contact/view/contact_screen.dart';

import '../../../core/utils/functions/size_config.dart';
import '../../group_chat_tabs/view/group_chat_tabs_screen.dart';
import '../../profile/view/profile_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepositoryImpl appRepositoryImpl;
  HomeCubit({required this.appRepositoryImpl}) : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  getUserData(context) async {
    log("enter");
    userModel = await appRepositoryImpl.onGetUserSavedData();
    emit(GetUserDataState());
 
    appBarHead = [
      Hero(
        tag: userModel!.image!,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    tag: userModel!.image!,
                    userModel: userModel!,
                  ),
                ));
          },
          child: CircleAvatar(
            backgroundColor: AppColor.primary,
            radius: getWidth(26),
            foregroundImage: NetworkImage(userModel!.image!),
          ),
        ),
      ),
      Text(
        "Call Logs",
        style: TextStyle(
            color: Colors.white,
            fontSize: getFont(28),
            fontWeight: FontWeight.w700),
      ),
      Text(
        "Contact",
        style: TextStyle(
            color: Colors.white,
            fontSize: getFont(28),
            fontWeight: FontWeight.w700),
      ),
    ];
  }

  List<String> head = ["Chat", "Calls", "Contact"];
  List<Widget> pages = [
   const GroupChatTabsScreen(),
    // const CallScreen(),
    const ContactScreen()
  ];
  List<Widget> appBarHead = [];
  int selectedIndex = 0;
  changePage(int index) {
    emit(HomeInitial());
    selectedIndex = index;
    emit(ChangePageIndexState());
  }
}
