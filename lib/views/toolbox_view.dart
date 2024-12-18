import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:sexeducation/widgets/app_bar.dart';
import 'package:sexeducation/views/calendar_view.dart';

class ToolboxView extends StatelessWidget {
  ToolboxView({super.key});
  static String name = 'toolbox';

  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Boite à outils'),
      bottomNavigationBar: const AppBarFooter(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: List.generate(4, (index) {
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(CalendarView.name);
              },
              child: const Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handyman, size: 50),
                    SizedBox(height: 8),
                    Text('Ressources', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
