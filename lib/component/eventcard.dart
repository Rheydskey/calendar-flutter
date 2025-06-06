import 'package:calendar/libcalendar/event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color(0xFF6750a4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        spacing: 4.0,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 6.0,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF21005d),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.name, style: TextStyle(color: Colors.white)),
                if (event.end.difference(event.start).inMinutes >= 60)
                  Text(
                    "${event.start.hour}h${event.start.minute.toString().padLeft(2, '0')} - ${event.end.hour}h${event.end.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
