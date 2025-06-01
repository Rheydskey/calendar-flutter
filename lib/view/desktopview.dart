import 'package:flutter/material.dart';

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

class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: "Eeee",
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Text("eee"),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(left: 3.0),
        height: 50.0,
        child: Text("TODO"),
      ),
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
            children: [
              for (int i = 0; i < 5; i += 1)
                DragTarget<String>(
                  builder: (context, candidateItems, rejectedItems) {
                    if (day % (i + 1) == 0) {
                      return SizedBox(
                        height: 50.0,
                        child:
                            candidateItems.isNotEmpty
                                ? ColoredBox(color: Colors.blue)
                                : ColoredBox(color: Colors.white),
                      );
                    } else {
                      return EventWidget();
                    }
                  },
                  onAcceptWithDetails: (details) {
                    print(details.data);
                  },
                ),
            ],
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
            Expanded(flex: 1, child: Stack(children: [CalendarColumn()])),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Stack(
        children: [
          Column(
            children: [
              for (int day = 0; day < 24; day += 1)
                SizedBox(
                  height: 60.0,
                  child: Text('${day.toString().padLeft(2, '0')}h'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class Desktopview extends StatelessWidget {
  const Desktopview({required this.title, super.key});

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
