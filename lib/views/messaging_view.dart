import 'package:flutter/material.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:sexeducation/widgets/app_bar.dart';

class MessagingView extends StatelessWidget {
  MessagingView({super.key});
  static String name = 'messaging';

  final List<String> discussionNames = [
    'Ghyslaine',
    'IA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Messagerie'),
      bottomNavigationBar: const AppBarFooter(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: discussionNames.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(discussionNames[index]),
              onTap: () {
                // Handle discussion tap
              },
            ),
          );
        },
      ),
    );
  }
}
