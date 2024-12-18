import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/state_management/posts/posts_cubit.dart';
import 'package:sexeducation/state_management/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:sexeducation/widgets/app_bar.dart';
import 'package:sexeducation/widgets/posts/postlist_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  static String name = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ThemeAppBar(title: 'Accueil'),
        bottomNavigationBar: const AppBarFooter(),
        body: BlocProvider<PostsCubit>(
          create: (context) {
            final cubit = PostsCubit();
            cubit.getPosts();
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
                return PostsList(
                  posts: state.posts,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
