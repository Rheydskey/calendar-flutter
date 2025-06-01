import 'package:calendar/libcalendar/event.dart';

abstract class Provider {
  Future<Events> getEvents();
}
