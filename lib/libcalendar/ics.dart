import 'package:calendar/libcalendar/event.dart';
import 'package:calendar/libcalendar/provider.dart';
import 'package:http/http.dart' as http;
import 'package:icalendar_parser/icalendar_parser.dart';

class Ics implements Provider {
  String url = "localhost:3000";
  String creds = "";

  @override
  Future<Events> getEvents() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': creds},
    );

    if (response.statusCode != 200) {
      throw Exception("Cannot get events : Bad status code");
    }
    final data = ICalendar.fromString(response.body).data;

    final eventData = [
      for (final key in data)
        if (key["type"] == "VEVENT") key,
    ];

    return Events(
      events:
          eventData
              .map(
                (elt) => Event(
                  name: elt["summary"],
                  start: (elt["dtstart"] as IcsDateTime).toDateTime()!,
                  end: (elt["dtend"] as IcsDateTime).toDateTime()!,
                ),
              )
              .toList(),
    );
  }
}
