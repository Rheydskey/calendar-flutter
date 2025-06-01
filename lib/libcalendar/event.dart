class Events {
  List<Event> events;

  Events({required this.events});

  List<Event> getEventOfDay(DateTime dt) {
    return events
        .where(
          (e) =>
              "${e.start.day}/${e.start.month}/${e.start.year}" ==
              "${dt.day}/${dt.month}/${dt.year}",
        )
        .toList();
  }

  @override
  String toString() {
    return "Events { events:${events.toString()} }";
  }
}

class Event {
  String name;
  DateTime start;
  DateTime end;

  Event({required this.name, required this.start, required this.end});

  @override
  String toString() {
    return "Event { name: ${name.toString()}, start: ${start.toString()}, end: ${end.toString()}}";
  }
}
