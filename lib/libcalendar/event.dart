// Extract from collection library
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

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

  Map<DateTime, List<Event>> asMap() {
    return groupBy(events, (event) => event.start);
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
