import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/repository/group_repository/group_repository_impl.dart';
import 'package:skype/core/utils/functions/uplaod_img_video_firebase.dart';
import 'package:skype/modules/group/model/group_model.dart';

import '../../../core/utils/functions/pick_image.dart';
import '../../chats/model/user_model.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GroupRepositoryImpl groupRepositoryImpl;
  GroupCubit(this.groupRepositoryImpl) : super(GroupInitial());
  static GroupCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final groupNameController = TextEditingController();
  UserModel? userModel;
  getUserdata() async {
    groupSelectedIdList = [];
    userModel = await groupRepositoryImpl.onGetUserSavedData();
    groupSelectedIdList.add(userModel!.userid);
    emit(GetUserDataState());
  }

  bool isNextStepGroup = false;
  bool isLodingGroupData = false;
  File? imageFile;
  String groupImage =
      'https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/userImg.png?alt=media&token=4f962df4-7c2d-4dd2-8950-f64e1ed9863d';
  List userFriend = [];
  List<UserModel> userFriendData = [];
  friends(users) {
    userFriend = users;
    getrindUserdata(users);
    emit(GetUserFrindsState());
  }

  getFrinds() async {
    final frinds = await groupRepositoryImpl.getFrindsIds();
    friends(frinds);
  }

  getrindUserdata(users) async {
    emit(StartGettingFriendDataState());
    userFriendData = await groupRepositoryImpl.getFrindsData(friendsId: users);
    log(userFriendData.length.toString());

    emit(GetFriendDataState());
  }

  List<GroupModel> userGroup = [];
  bool isLoadingGroup = false;
  getGroups() async {
    isLoadingGroup = true;
    emit(StartLoadingUserGroupState());
    userGroup = await groupRepositoryImpl.getGroup();
    isLoadingGroup = false;
    emit(GetUserGroupState());
  }

  List groupSelectedIdList = [];
  addToSelected({required String id, required bool isCheck}) {
    if (isCheck) {
      groupSelectedIdList.add(id);
    } else {
      groupSelectedIdList.remove(id);
    }
    log(groupSelectedIdList.toString());
  }

  getGroupImage() async {
    imageFile = await getImagePicker(isCamera: false);
  }

  bool isLoadingCreateGroup = false;
  createGroup({required context}) async {
    isLoadingCreateGroup = true;
    emit(EndLoadingCreateGroupState());

    if (imageFile != null) {
      groupImage = await uploadImageVideoFirebase(
          itemFile: imageFile!, folder: "groupImage");
    }
    await groupRepositoryImpl.createGroup(
        name: groupNameController.text.trim(),
        image: groupImage,
        groupMember: groupSelectedIdList);
    Navigator.pop(context);
    isNextStepGroup = false;
      isLoadingCreateGroup = false;
    emit(EndLoadingCreateGroupState());
   getUserdata();
                                   getFrinds();
                                getGroups();

  
  }
}
