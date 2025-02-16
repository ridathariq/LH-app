import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Import this

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _focusedDay = DateTime.now(); // Currently focused date
  DateTime? _selectedDay; // Selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TableCalendar(
              firstDay: DateTime(2020, 1, 1),
              lastDay: DateTime(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // Update the focused day
                });
              },
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Color(0xFFF65A38), // Orange
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFF65A38), // Orange
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: const Color(0xFFC8E3C7), // Light Green
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: const TextStyle(color: Color(0xFF1E1E1E)), // Dark Charcoal
                weekendTextStyle: const TextStyle(color: Color(0xFFF65A38)), // Orange
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: _selectedDay != null
                  ? Text(
                      "Selected Date: ${_selectedDay!.toLocal()}".split(' ')[0],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E), // Dark Charcoal
                      ),
                    )
                  : const Text(
                      "Select a date to view attendance",
                      style: TextStyle(fontSize: 16, color: Color(0xFF1E1E1E)), // Dark Charcoal
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF65A38), // Orange
        unselectedItemColor: const Color(0xFF1E1E1E), // Dark Charcoal
        backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }
}
