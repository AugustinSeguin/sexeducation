part of 'search_cubit.dart';

abstract class SearchState {}

class SearchStateInitial extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<PostModel?> posts;

  SearchStateSuccess(this.posts);
}

class SearchStateError extends SearchState {
  final String message;

  SearchStateError(this.message);
}