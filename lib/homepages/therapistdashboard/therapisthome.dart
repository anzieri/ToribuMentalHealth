import "package:flutter/material.dart";
import 'package:table_calendar/table_calendar.dart';

class TherapistHomePage extends StatefulWidget {
  const TherapistHomePage({super.key});

  @override
  State<TherapistHomePage> createState() => _TherapistHomePageState();
}

class _TherapistHomePageState extends State<TherapistHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<AppointmentData> _appointments = [];
  // Process appointments for a specific day
  List<TimeSlot> _getTimeSlotsForDay(DateTime day) {
    // Default time slots
    final List<TimeSlot> timeSlots = [
      TimeSlot(time: "9:00 AM", status: "Available", color: Colors.green),
      TimeSlot(time: "10:00 AM", status: "Available", color: Colors.green),
      TimeSlot(time: "11:00 AM", status: "Available", color: Colors.green),
      TimeSlot(time: "12:00 PM", status: "Lunch Break", color: Colors.grey),
      TimeSlot(time: "1:00 PM", status: "Available", color: Colors.green),
      TimeSlot(time: "2:00 PM", status: "Available", color: Colors.green),
      TimeSlot(time: "3:00 PM", status: "Available", color: Colors.green),
      TimeSlot(time: "4:00 PM", status: "Available", color: Colors.green),
    ];

    final dayAppointments = _appointments.where((appointment) {
      return appointment.scheduledDate.year == day.year &&
          appointment.scheduledDate.month == day.month &&
          appointment.scheduledDate.day == day.day;
    }).toList();

    // Update time slots with appointments
    for (var appointment in dayAppointments) {
      final appointmentTime = _formatTime(appointment.scheduledDate);
      final index =
          timeSlots.indexWhere((slot) => slot.time == appointmentTime);

      if (index != -1) {
        Color statusColor;
        switch (appointment.status) {
          case "CONFIRMED":
            statusColor = Colors.blue;
            break;
          case "PENDING":
            statusColor = Colors.orange;
            break;
          case "CANCELLED":
            statusColor = Colors.red;
            break;
          default:
            statusColor = Colors.grey;
        }

        timeSlots[index] = TimeSlot(
          time: appointmentTime,
          status: "${appointment.user} - ${appointment.location}",
          color: statusColor,
        );
      }
    }

    return timeSlots;
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final period = hour >= 12 ? "PM" : "AM";
    final hourIn12 = hour > 12 ? hour - 12 : hour;
    return "$hourIn12:${dateTime.minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> _fetchAppointments() async {
    try {
      // Example API call
      // final response = await http.get(Uri.parse('your_api_endpoint/appointments'));
      // final List<dynamic> data = json.decode(response.body);

      // For testing, using sample data
      final List<dynamic> sampleData = [
        {
          "createdAtDate": "2024-03-21",
          "scheduledDate": "2024-03-21T10:30:00",
          "location": "Nairobi",
          "status": "CONFIRMED",
          "user": "John Doe"
        },
        {
          "createdAtDate": "2024-03-23",
          "scheduledDate": "2024-03-21T14:00:00",
          "location": "Mombasa",
          "status": "PENDING",
          "user": "Jane Smith"
        },
      ];

      setState(() {
        _appointments =
            sampleData.map((json) => AppointmentData.fromJson(json)).toList();
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      // You might want to show an error message to the user
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = _getTimeSlotsForDay(_selectedDay ?? _focusedDay);
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        height: MediaQuery.of(context).size.height, // Constrain the height
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Welcome Section
                      const Text(
                        "Welcome back, Dr. Smith",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Stats Cards Row
                      Row(
                        children: [
                          _buildStatCard(
                            "Upcoming Sessions",
                            "5",
                            Colors.blue.shade50,
                            Icons.calendar_today,
                          ),
                          const SizedBox(width: 20),
                          _buildStatCard(
                            "Total Patients",
                            "28",
                            Colors.green.shade50,
                            Icons.people,
                          ),
                          const SizedBox(width: 20),
                          _buildStatCard(
                            "Messages",
                            "3",
                            Colors.orange.shade50,
                            Icons.message,
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                      const SizedBox(height: 40),

                      // Calendar Section
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            TableCalendar(
                              firstDay: DateTime.utc(2024, 1, 1),
                              lastDay: DateTime.utc(2024, 12, 31),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: true,
                                titleCentered: true,
                                formatButtonShowsNext: false,
                                titleTextStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Appointments for ${_selectedDay?.toString().split(' ')[0] ?? 'Today'}",
                                        style: const TextStyle(
                                          fontFamily: 'Lexend',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.refresh),
                                        onPressed: _fetchAppointments,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  ...timeSlots.map((slot) => _buildTimeSlot(
                                        slot.time,
                                        slot.status,
                                        slot.color,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Today's Schedule Section
                      const Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildAppointmentCard(
                        "9:00 AM",
                        "Jane Cooper",
                        "Individual Session",
                        Colors.blue.shade100,
                      ),
                      const SizedBox(height: 15),
                      _buildAppointmentCard(
                        "11:30 AM",
                        "Robert Fox",
                        "Follow-up Session",
                        Colors.green.shade100,
                      ),
                      const SizedBox(height: 15),
                      _buildAppointmentCard(
                        "2:00 PM",
                        "Wade Warren",
                        "Initial Consultation",
                        Colors.purple.shade100,
                      ),
                    ],
                  ),
                ));
  }

  Widget _buildStatCard(
      String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 15),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            status,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(
      String time, String patient, String type, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  type,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class TimeSlot {
  final String time;
  final String status;
  final Color color;

  TimeSlot({
    required this.time,
    required this.status,
    required this.color,
  });
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: TherapistHomePage(),
    ),
  ));
}

class AppointmentData {
  final DateTime createdAtDate;
  final DateTime scheduledDate;
  final String location;
  final String status;
  final String user;

  AppointmentData({
    required this.createdAtDate,
    required this.scheduledDate,
    required this.location,
    required this.status,
    required this.user,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      createdAtDate: DateTime.parse(json['createdAtDate']),
      scheduledDate: DateTime.parse(json['scheduledDate']),
      location: json['location'],
      status: json['status'],
      user: json['user'],
    );
  }
}
