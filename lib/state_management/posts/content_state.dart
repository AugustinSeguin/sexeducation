import 'package:sexeducation/models/post_model.dart';

abstract class PostState {}

class PostStateInitial extends PostState {}

class PostStateLoading extends PostState {}

class PostStateSuccess extends PostState {
  final List<PostModel> posts;
  PostStateSuccess(this.posts);
}

class OnePostStateSuccess extends PostState {
  final PostModel? post;

  OnePostStateSuccess(this.post);
}

class ReportPostStateSuccess extends PostState {}

class PostsStateError extends PostState {
  final String message;
  PostsStateError(this.message);
}
