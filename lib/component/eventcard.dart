import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shadowColor: Colors.transparent,
      color: Color(0xFF6750a4),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bonjour", style: TextStyle(color: Colors.white)),
              Text("10h -> 12h", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
