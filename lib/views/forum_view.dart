import 'package:flutter/material.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:sexeducation/widgets/app_bar.dart';

class ForumView extends StatelessWidget {
  ForumView({super.key});
  static String name = 'forum';

  final List<String> threadTitles = [
    'Questions sans tabou : parlons sexualité en toute liberté !',
    'Mieux comprendre son corps : vos questions, nos réponses',
    'Amour, consentement et relations : partageons nos expériences',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Forum'),
      bottomNavigationBar: const AppBarFooter(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: threadTitles.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(threadTitles[index]),
              onTap: () {
              },
            ),
          );
        },
      ),
    );
  }
}
