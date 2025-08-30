import 'package:calendar/libcalendar/event.dart';
import 'package:calendar/view/mobile/calendar/mobile.dart';
import 'package:calendar/view/mobile/calendar/planner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MobileView(),
    );
  }
}
