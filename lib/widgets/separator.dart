import 'package:flutter/material.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';

class Separator extends StatelessWidget {
  const Separator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: lightColorScheme.outline,
        ),
      ],
    );
  }
}