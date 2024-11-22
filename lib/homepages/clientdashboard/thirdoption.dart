import 'package:app2/requests/loginlogic.dart';
import 'package:app2/requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:intl/intl.dart';

class ClientAppointments extends StatefulWidget {
  const ClientAppointments({super.key});

  @override
  State<ClientAppointments> createState() => _ClientAppointmentsState();
}

class _ClientAppointmentsState extends State<ClientAppointments>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  String _selectedLocation = 'Nairobi';
  final List<String> _locations = ['Nairobi', 'Mombasa', 'Kisumu', 'Nakuru'];
  bool _isLoading = false;

  Map<String, dynamic> appointmentData = {
    'createdAtDate': '',
    'scheduledDate': '',
    'location': '',
    'status': '',
    'clientEmail': '',
    'therapistEmail': '',
  };

  //     }),

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  //DateTime createdAt = DateTime.now();

  String getCreatedAt(createdAt) {
    final DateTime newCreatedAt = DateTime(
      createdAt.year,
      createdAt.month,
      createdAt.day,
    );
    return DateFormat('yyyy-MM-dd').format(newCreatedAt);
  }

  String getFormattedDateTime() {
    final DateTime combinedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(combinedDateTime);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 192, 143),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height -
            80, // Adjust this value as needed
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Lets book an appointment😊',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 40,
              fontWeight: FontWeight.w400,),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: 400,
              child: EasyDateTimeLine(
                disabledDates: List.generate(365 * 5, (index) => DateTime.now().subtract(Duration(days: index + 1))),
                initialDate: _selectedDate,
                onDateChange: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected time: ${_selectedTime.format(context)}',
              style: const  TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w200,),
            ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time', style:  TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w200,)),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                print(_selectedDate);
                print(_selectedTime);
                print(getFormattedDateTime());
                String scheduledDate = getFormattedDateTime();
                DateTime createdAtDate = DateTime.now();
                String createdAt = getCreatedAt(createdAtDate);
                appointmentData['scheduledDate'] = scheduledDate;
                appointmentData['createdAtDate'] = createdAt;
                appointmentData['location'] = _selectedLocation;
                appointmentData['status'] = 'PENDING';
                appointmentData['clientEmail'] = getClientEmail(getToken()!);
                appointmentData['therapistEmail'] = getTherapistEmail();
                
                try {
                  saveAppointments(appointmentData);
                } catch (e) {
                  showDialog(
                    context: context,
                     builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text('An error occurred while booking the appointment\n$e'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                     },
                  );
                }
                
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Appointment Booked'),
                      content: Text('Your appointment has been booked successfully\nWe will notify you once the therapist confirms the appointment\n $scheduledDate'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } ,
              child: const Text('Book Appointment', style:  TextStyle(
              fontFamily: 'Lexend',
              fontSize: 24,
              fontWeight: FontWeight.w200,)),
            ),
          ],
        ),
        )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ClientAppointments(),
    ),
  ));
}
