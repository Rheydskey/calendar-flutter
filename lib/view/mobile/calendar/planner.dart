import 'package:calendar/component/eventcard.dart';
import 'package:calendar/libcalendar/event.dart';
import 'package:flutter/material.dart';

class MobileCalendarPlanner extends StatelessWidget {
  final Map<DateTime, List<Event>> events;

  const MobileCalendarPlanner(this.events, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: events.entries.map((e) {
        final dt = e.key;
        final events = e.value;
        return _buildDay(context, dt, events);
      }).toList(),
    );
  }

  Widget _buildDay(BuildContext context, DateTime time, List<Event> events) {
    return SliverMainAxisGroup(
      key: ValueKey(time),
      slivers: [_buildHeader(context, time), _buildItemsOfDay(events)],
    );
  }

  Widget _buildHeader(BuildContext context, DateTime day) {
    return SliverAppBar(
      title: Row(
        spacing: 10.0,
        children: [
          Text("${day.day}/${day.month}"),
          Expanded(child: Divider()),
        ],
      ),
      pinned: true,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
    );
  }

  Widget _buildItemsOfDay(List<Event> events) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: events.length, (
        context,
        index,
      ) {
        return Container(
          height: 100,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
          margin: EdgeInsetsDirectional.only(top: 5.0),
          child: EventCard(events[index]),
        );
      }),
    );
  }
}
