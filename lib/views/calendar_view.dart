import 'package:flutter/material.dart';
import 'package:sexeducation/widgets/app_bar.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';

// PostBodyImage is a widget inside PostBody that
// displays the image of the post if it exists

class CalendarView extends StatelessWidget {
  CalendarView({super.key});
  static String name = 'calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Calendrier menstruel'),
      bottomNavigationBar: const AppBarFooter(),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        width: 500,
        height: 500,
        child: Image.asset('assets/calendar-menstruel.png'),
      ),
    );
  }
}
