part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class LoaingSearchState extends SearchState {}
class FailedSearchState extends SearchState {}
class SuccessSearchState extends SearchState {}
class SearchUserState extends SearchState {}
class AddedFrindState extends SearchState {}
class AddedFrindtOUserState extends SearchState {}
class TextFieldOnChangeAction extends SearchState {}
class GetFrindsIdState extends SearchState {}
