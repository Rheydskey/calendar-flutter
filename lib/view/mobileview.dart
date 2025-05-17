import 'package:calendar/component/eventcard.dart';
import 'package:calendar/view/desktopview.dart';
import 'package:flutter/material.dart';

class Mobileview extends StatelessWidget {
  const Mobileview({super.key});
  static const List<String> jours = [
    "16 mai",
    "17 mai",
    "18 mai",
    "19 mai",
    "20 mai",
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: jours.length,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          selectedIndex: 1,
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
          bottom: TabBar(
            tabs:
                jours
                    .map(
                      (f) => Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(f),
                      ),
                    )
                    .toList(),
          ),
        ),
        drawer: Drawer(child: Text("Truc")),
        body: TabBarView(
          children: <Widget>[
            ListView(
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
            ListView(
              children: [
                Row(children: [HourHint()]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
