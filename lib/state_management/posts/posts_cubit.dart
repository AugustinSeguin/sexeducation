import 'package:sexeducation/services/post_service.dart';
import 'package:sexeducation/state_management/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<PostState> {
  PostsCubit() : super(PostStateInitial());

  static final PostService postService = PostService();

  Future<void> getPosts() async {
    try {
      emit(PostStateLoading());
      final posts = await postService.getPosts();
      debugPrint("posts: ${posts[0].description}");
      emit(PostStateSuccess(posts));
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer les publications. Veuillez réessayer."));
    }
  }

  Future<void> getOnePost(int postId) async {
    try {
      final PostService postService = PostService();
      emit(PostStateLoading());
      final post = await postService.getOnePost(postId);
      emit(OnePostStateSuccess(post));
    } catch (error) {
      debugPrint(error.toString());
      emit(PostsStateError(
          "Erreur rencontrée pour récupérer la publication. Veuillez réessayer."));
    }
  }

  Future<void> submitReport(int postId, String result) async {
    try {
      emit(PostStateLoading());

      final postService = PostService();
      await postService.submitReport(postId, result);

      emit(ReportPostStateSuccess());
    } catch (error) {
      emit(PostsStateError(
          "Erreur rencontrée lors du signalement. Veuillez réessayer."));
    }
  }
}
