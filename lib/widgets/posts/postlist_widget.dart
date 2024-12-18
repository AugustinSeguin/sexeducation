import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/state_management/authentication/authentication_cubit.dart';
import 'package:sexeducation/state_management/posts/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/widgets/posts/post_widget.dart';

class PostsList extends StatefulWidget {
  PostsList({
    super.key,
    required this.posts,
  });

  static String name = 'posts-list';
  final List<PostModel> posts;

  @override
  _PostsList createState() => _PostsList();
}

class _PostsList extends State<PostsList> {
  // Functions which allows to indicate to the
  // parent view that the page has been scrolled
  final ScrollController _scrollController = ScrollController();

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      context.read<PostsCubit>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PostModel> posts = widget.posts;

    return NotificationListener(
      child: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refreshData,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          controller: _scrollController,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < posts.length) {
              return InkWell(
                child: PostWidget(post: posts[index]),
              );
            }
            return const Center(
              child: Text("Pas de nouvelles publications à afficher"),
            );
          },
        ),
      ),
    );
  }
}
