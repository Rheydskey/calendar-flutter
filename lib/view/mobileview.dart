import 'package:calendar/component/eventcard.dart';
import 'package:calendar/view/desktopview.dart';
import 'package:flutter/material.dart';

class DayColumn extends StatelessWidget {
  const DayColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(children: [HourHint()]),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Column(
                    spacing: 59.0,
                    children: [
                      SizedBox(height: 10.0),
                      for (var i = 1; i <= 24; i++)
                        Divider(
                          height: 1.0,
                          indent: 10,
                          endIndent: 10,
                          color: Color(0xFFeaddff),
                        ),
                    ],
                  ),
                  Column(
                    spacing: 2,
                    children: [
                      for (var i = 1; i <= 10; i++)
                        SizedBox(height: 58, child: EventCard()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String format() {
  var date = DateTime.now();
  return "${date.day}/${date.month}";
}

class MobileCalendarView extends StatelessWidget {
  const MobileCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        DayColumn(),
        ListView(
          children: [
            Row(children: [HourHint()]),
          ],
        ),
        ListView(
          children: [
            Row(children: [HourHint()]),
          ],
        ),
        ListView(
          children: [
            Row(children: [HourHint()]),
          ],
        ),
        ListView(
          children: [
            Row(children: [HourHint()]),
          ],
        ),
      ],
    );
  }
}

class Tracker extends StatelessWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Default",
                  style: TextTheme.of(context).headlineLarge,
                ),
              ),
            ],
          ),

          Wrap(
            spacing: 0.0,

            children: List.generate(
              DateUtils.getDaysInMonth(
                DateTime.now().year,
                DateTime.now().month,
              ),
              (_) => Checkbox(value: false, onChanged: (a) {}),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileTrackerView extends StatelessWidget {
  const MobileTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [Tracker()]);
  }
}

class Mobileview extends StatefulWidget {
  const Mobileview({super.key});

  @override
  State<Mobileview> createState() => _MobileviewState();
}

class _MobileviewState extends State<Mobileview> {
  int selectedview = 1;
  Tab? tab;

  static List<String> jours = [
    format(),
    format(),
    format(),
    format(),
    format(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedview,
        onDestinationSelected: (int index) {
          setState(() {
            selectedview = index;
          });
        },
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home), label: "Home"),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: const Icon(Icons.error),
            label: "Deadlines",
          ),
          NavigationDestination(icon: const Icon(Icons.menu), label: "Other"),
        ],
      ),
      appBar: AppBar(
        title: Text("16 mai"),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [Icon(Icons.settings)],
        actionsPadding: EdgeInsets.all(10.0),
      ),
      drawer: Drawer(child: Text("Truc")),
      body: () {
        if (selectedview == 0) {
          return MobileCalendarView();
        } else {
          return MobileTrackerView();
        }
      }(),
    );
  }
}
