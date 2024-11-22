import "package:flutter/material.dart";
import "package:syncfusion_flutter_calendar/calendar.dart";

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  late MeetingDataSource _events;
  late List<Appointment> _shiftCollection;

  @override
  void initState() {
    // TODO: implement initState
    //_events = MeetingDataSource(_shiftCollection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(70, 10, 70, 10),
      padding: const EdgeInsets.fromLTRB(40, 10, 10, 5),
      //width: 1500,
      height: 900,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: SfCalendar(
        view: CalendarView.month,
        //CalendarView.workWeek,
        firstDayOfWeek: 1,
        //headerDateFormat: "EEEE",

        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[200],
        ),

        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 80,
          timeIntervalWidth: 80,
          timeRulerSize: 50,
          startHour: 9,
          endHour: 18,
        ),
        dataSource: MeetingDataSource(getAppointments()),
        //nonWorkingDays: <int>[DateTime.saturday, DateTime.sunday],
        //dataSource: _events
      ),
    );
  }

  void addAppointments() {
    var subjectCollection = <String>[
      'Conference',
      'Meeting',
      'Interview',
      'Presentation',
      'Training',
      'Project Review'
    ];
  }
  //_shiftCollection = <Appointment>[];

  // for(int j = 0;)
}

// List<Appointment> getAppointments(){
//   List<Appointment> shiftCollection = <Appointment>[];
//   shiftCollection.add(Appointment(
//     startTime: DateTime.now(),
//     endTime: DateTime.now().add(const Duration(hours: 2)),
//     subject: 'Meeting',
//     color: Colors.blue,
//     startTimeZone: '',
//     endTimeZone: '',
//   ));
//   return shiftCollection;
// }

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1, minutes: 30));
  //
  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Conference',
    notes: "Get that position.",
    color: Colors.blue,
    startTimeZone: '',
    endTimeZone: '',
  ));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: CalenderView(),
    ),
  ));
}
