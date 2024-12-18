import 'package:sexeducation/widgets/posts/post_body/post_body_details.dart';
import 'package:sexeducation/widgets/posts/post_body/post_body_image.dart';
import 'package:sexeducation/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:sexeducation/widgets/separator.dart';
import 'package:sexeducation/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';
import 'package:go_router/go_router.dart';

// PostBody is a widget that displays the body of a post
// It contains wdgets for
// the image, the stats and the details of the post

class PostBody extends StatelessWidget {
  const PostBody({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.image != null) ...[
          PostBodyImage(imageUrl: post.image),
          const SizedBox(height: 8),
        ] else ...[
          const Separator(),
        ],
        const Separator(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PostBodyDetails(post: post),
        ),
      ],
    );
  }
}
