import 'package:app2/centered_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
class DateSelect extends StatelessWidget {
  const DateSelect({super.key});

  @override
  Widget build(BuildContext context) {
    
    return CenteredView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(70, 5, 70, 0),
        child: EasyDateTimeLine(
        initialDate: DateTime.now(),
        disabledDates: List.generate(365 * 5, (index) => DateTime.now().subtract(Duration(days: index + 1))),
        onDateChange: (selectedDate) {
          
        },
        activeColor: const Color.fromARGB(255, 22, 11, 100),
        headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        dateFormatter: DateFormatter.fullDateDayAsStrMY(),
      ),
        
        )
      )
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: DateSelect(),
    ),
  ));
}