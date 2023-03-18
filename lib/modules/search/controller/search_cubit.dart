import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skype/core/utils/functions/app_toast.dart';
import 'package:skype/modules/chats/model/user_model.dart';

import '../../../core/repository/search_repository/search_repository_impl.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepositoryImpl searchRepositoryImpl;
  SearchCubit({required this.searchRepositoryImpl}) : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  final searchController = TextEditingController();
  List<UserModel> users = [];
  bool isLoadingUsers = false;
  bool isSuceesAndEmpty = false;
  onChangeTextSearch(value) {
    emit(SearchInitial());

    if (value.isNotEmpty) {
      searchedUser.clear();
      search(value.toString());
    } else {
      searchedUser.clear();
    }
    emit(TextFieldOnChangeAction());
  }

  getUserBySearch() async {
    isLoadingUsers = true;
    emit(LoaingSearchState());
    final searchRes = await searchRepositoryImpl.getUSuserBySearch();

    searchRes.fold((fail) {
      appToast(fail.toString());
      isLoadingUsers = false;

      emit(FailedSearchState());
    }, (users) {
      this.users = users;
      isLoadingUsers = false;

      emit(SuccessSearchState());
    });
  }

  List<UserModel> searchedUser = [];
  search(String name) {
    emit(SearchInitial());

    for (UserModel element in users) {
      if (element.name!.toLowerCase().contains(name.toLowerCase().trim())) {
        searchedUser.add(element);
      }
    }
    if (searchedUser.isEmpty) {
      isSuceesAndEmpty = true;
    } else {
      isSuceesAndEmpty = false;
    }
    emit(SearchUserState());
  }

  addFrind({required String name, required String reciverId, context}) async {
    await searchRepositoryImpl.addFrind(name: name, reciverId: reciverId);
    emit(AddedFrindState());

    await searchRepositoryImpl.addFriendToUser(
        friendId: reciverId, context: context);
    emit(AddedFrindtOUserState());
  }
}
