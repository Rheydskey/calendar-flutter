import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AppWidget(title: 'Calendar'),
    );
  }
}

class Event extends StatelessWidget {
  const Event({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red, child: Text("eeee"));
  }
}

class DayTitle extends StatelessWidget {
  const DayTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(" H"),
        Expanded(flex: 1, child: Center(child: Text("Lundi"))),
        Expanded(flex: 1, child: Center(child: Text("Mardi"))),
        Expanded(flex: 1, child: Center(child: Text("Mercredi"))),
        Expanded(flex: 1, child: Center(child: Text("Jeudi"))),
        Expanded(flex: 1, child: Center(child: Text("Vendredi"))),
      ],
    );
  }
}

class CalendarColumn extends StatelessWidget {
  const CalendarColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
      },
      border: TableBorder.all(
        color: Colors.black,
        style: BorderStyle.solid,
        width: 1,
      ),
      children: [
        for (int day = 0; day < 24; day += 1)
          TableRow(
            children: [for (int i = 0; i < 5; i += 1) SizedBox(height: 50.0)],
          ),
      ],
    );
  }
}

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            HourHint(),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Container(color: Colors.amber, width: 10.0, height: 10.0),
                  CalendarColumn(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class HourHint extends StatelessWidget {
  const HourHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int day = 0; day < 24; day += 1)
          SizedBox(height: 50.0, child: Text(day.toString())),
      ],
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({required this.title, super.key});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(children: [DayTitle(), Expanded(child: CalendarGrid())]),
    );
  }
}
