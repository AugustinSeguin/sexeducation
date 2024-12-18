import 'package:sexeducation/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:sexeducation/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';

// PostBodyDetails is a widget inside PostBody that
// displays the details of the post : title, description and tags

class PostBodyDetails extends StatelessWidget {
  final PostModel post;

  const PostBodyDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post.title ?? '',
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (post.description != null) ...[
          const SizedBox(height: 10),
          Text(post.description!),
        ],
      ],
    );
  }
}
