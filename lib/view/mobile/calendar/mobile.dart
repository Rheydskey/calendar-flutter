import 'package:calendar/libcalendar/event.dart';
import 'package:calendar/view/mobile/calendar/planner.dart';
import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<StatefulWidget> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    var a = DateTime.now();
    var b = DateTime(a.year, a.month, a.day);
    var c = b.add(Duration(hours: 2));
    final event = Events(
      events: [
        for (final i in [0, 1, 2, 3, 4, 5, 6, 7])
          Event(
            name: "Test",
            start: b.add(Duration(days: i)),
            end: c.add(Duration(days: i)),
          ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text("Tous les évènements")),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: MobileCalendarPlanner(event.asMap()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: false,

            builder: (ctx) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: DraggableScrollableSheet(
                initialChildSize: 1,
                builder: (context, scrollController) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(children: [Text("Add an event"), EventForm()]),
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  final String labelText;

  const DatePicker({super.key, required this.labelText});

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Date de l'évènement",
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      controller: TextEditingController(
        text: _selectedDate != null
            ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
            : "",
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now().subtract(
            const Duration(days: 365 * 50),
          ), // 50 years
          lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      validator: (value) {
        if (_selectedDate == null) {
          return "Veuillez sélectionner une date";
        }
        return null;
      },
    );
  }
}

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<StatefulWidget> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("eeee")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 10.0,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text("Nom de l'évènement")),
          ),
          DatePicker(labelText: "Début"),
          DatePicker(labelText: "Fin"),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Submit calendar"),
          ),
        ],
      ),
    );
  }
}
