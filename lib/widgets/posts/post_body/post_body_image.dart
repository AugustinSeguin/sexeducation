import 'package:flutter/material.dart';

// PostBodyImage is a widget inside PostBody that
// displays the image of the post if it exists

class PostBodyImage extends StatelessWidget {
  final String? imageUrl;

  const PostBodyImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(20),
      width: 500,
      height: 500,
      child: Image.asset('assets/taboo.png'),
    );
  }
}
