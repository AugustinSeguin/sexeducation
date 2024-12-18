import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/models/post_model.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/state_management/authentication/authentication_cubit.dart';
import 'package:sexeducation/state_management/posts/posts_cubit.dart';
import 'package:sexeducation/widgets/posts/post_body/post_body.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';

// SinglePostWidget is a widget that displays a single post.
// It contains the header, body, and footer of the post.

class PostWidget extends StatelessWidget {
  const PostWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = context.watch<AuthenticationCubit>().state.user;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<PostsCubit>().getOnePost(post.id!);
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: lightColorScheme.outline),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostBody(post: post)
            ],
          ),
        ),
      ),
    );
  }
}
