import 'dart:async';

import 'package:calendar/component/eventcard.dart';
import 'package:calendar/libcalendar/event.dart' as evt;
import 'package:calendar/libcalendar/ics.dart';
import 'package:calendar/preferences/preferences.dart';
import 'package:calendar/view/desktopview.dart';
import 'package:flutter/material.dart';

const hourSize = 60.0;
const minuteSize = hourSize / Duration.minutesPerHour;

class HourDivider extends StatelessWidget {
  const HourDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: hourSize - 1,
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
    );
  }
}

class EventColumn extends StatelessWidget {
  final List<evt.Event> events;
  const EventColumn(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      children: [
        Stack(
          children: [
            for (var e in events)
              Container(
                margin: EdgeInsets.only(
                  top:
                      10.0 +
                      (e.start.hour) * hourSize +
                      (e.start.minute) * minuteSize,
                ),
                height:
                    (e.end.difference(e.start).inMinutes / 60).toInt() *
                        hourSize +
                    (e.end.difference(e.start).inMinutes % 60).toInt() *
                        minuteSize,
                child: EventCard(e),
              ),
          ],
        ),
      ],
    );
  }
}

class CurrentHour extends StatefulWidget {
  const CurrentHour({super.key});

  @override
  State<CurrentHour> createState() => _CurrentHourState();
}

class _CurrentHourState extends State<CurrentHour> {
  DateTime dt = DateTime.now();
  late Timer update;

  void updateTime(e) {
    setState(() {
      dt = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();

    // SUBOPTIMIZE
    update = Timer.periodic(Duration(seconds: 1), updateTime);
  }

  @override
  void dispose() {
    super.dispose();
    update.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: dt.hour * hourSize + dt.minute * minuteSize),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.horizontal(
                left: Radius.elliptical(10.0, 10.0),
                right: Radius.elliptical(10.0, 10.0),
              ),
            ),

            padding: EdgeInsets.all(2.0),
            child: Text(
              "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.red, height: 2.0, thickness: 2.0),
          ),
        ],
      ),
    );
  }
}

class CurrentHourDivider extends StatefulWidget {
  const CurrentHourDivider({super.key});

  @override
  State<CurrentHourDivider> createState() => _CurrentHourDividerState();
}

class _CurrentHourDividerState extends State<CurrentHourDivider> {
  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: dt.hour * hourSize + dt.minute * minuteSize,
            ),
            height: 24.0,
            child: Divider(color: Colors.red, thickness: 1.0),
          ),
        ),
      ],
    );
  }
}

class DayColumn extends StatelessWidget {
  final List<evt.Event> events;
  const DayColumn(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [HourHint()]),
                Expanded(
                  flex: 1,
                  child: Stack(children: [HourDivider(), EventColumn(events)]),
                ),
              ],
            ),
            CurrentHour(),
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
  final List<evt.Event> event;

  const MobileCalendarView(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return DayColumn(event);
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
  int selectedview = 0;
  Tab? tab;
  evt.Events? events;
  Preferences? prefs;

  Future<void> getPrefs() async {
    prefs = await Preferences.getInstance();
  }

  Future<void> getEvent() async {
    /*prefs!.prefs.setString(
      "url",
      "",
    );*/

    /*prefs!.prefs.setString(
      "auth",
      "",
    );*/

    var url = prefs!.url()!;
    var auth = prefs!.auth()!;
    var events = await Ics(url, auth).getEvents();
    setState(() {
      this.events = events;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefs().whenComplete(() {
      getEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    var subview = () {
      if (selectedview == 0) {
        if (events == null) {
          return const CircularProgressIndicator();
        }

        return MobileCalendarView(events!.getEventOfDay(DateTime.now()));
      }

      return MobileTrackerView();
    }();
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
      body: Center(child: subview),
    );
  }
}
