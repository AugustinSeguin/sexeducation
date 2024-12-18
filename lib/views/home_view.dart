import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/state_management/posts/content_cubit.dart';
import 'package:sexeducation/state_management/posts/content_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:sexeducation/widgets/app_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static String name = 'home';
  int currentPage = 1;

  List<PostModel> allPosts =[];
  bool noMorePosts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Accueil'),
      bottomNavigationBar: const AppBarFooter(),
      body: BlocProvider<PostsCubit>(
        create: (context) {
          final cubit = PostsCubit();
          cubit.getPosts(currentPage);
          return cubit;
        },
        child: BlocBuilder<PostsCubit, PostState>(
          builder: (context, state) {
            if (state is PostStateInitial || state is PostStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostsStateError) {
              return Center(child: Text(state.message));
            } else if (state is PostStateSuccess) {
              allPosts += state.posts;
              if (state.posts.isEmpty) {
                noMorePosts = true;
              }
              return ListView(
                
              );
            }
            return const SizedBox.shrink();
          },
        ),
      )
    );
  }
}