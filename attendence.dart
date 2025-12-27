import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/screens/config.dart';

class AttendanceScreen extends StatefulWidget {
  final String registernumber;

  AttendanceScreen({required this.registernumber});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> attendanceData = [];
  bool isLoading = true;
  String errorMessage = '';
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  String getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  void changeMonth(int delta) {
    setState(() {
      if (delta > 0) {
        if (selectedMonth == 12) {
          selectedMonth = 1;
          selectedYear++;
        } else {
          selectedMonth++;
        }
      } else {
        if (selectedMonth == 1) {
          selectedMonth = 12;
          selectedYear--;
        } else {
          selectedMonth--;
        }
      }
      fetchAttendance();
    });
  }

  Future<void> fetchAttendance() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final url =
          'http://localhost:3000/attendance/student/${widget.registernumber}/$selectedYear/$selectedMonth';
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          attendanceData = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              'Server error: ${response.statusCode}\nBody: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Network error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Attendance', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
            
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => changeMonth(-1),
                  ),
                  Text(
                    '${getMonthName(selectedMonth)} $selectedYear',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () => changeMonth(1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(31, (index) {
                int day = index + 1;
                Map<String, dynamic>? record = attendanceData.firstWhere(
                  (rec) => int.parse(rec['date'].split('-')[2]) == day,
                  orElse: () => {},
                );
        
                String status = record.isNotEmpty
                    ? (record['isPresent'] ? 'Present' : 'Absent')
                    : 'Not Marked';
                Color textColor = Color(0xFF1E1E1E);
                Widget indicator = SizedBox.shrink();
        
                if (status == 'Present') {
                  indicator = Icon(Icons.circle, size: 8, color: Colors.green);
                } else if (status == 'Absent') {
                  indicator = Icon(Icons.circle, size: 8, color: Colors.red);
                }
        
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAF4E2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      indicator,
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegend(Colors.green, 'Full Day Present'),
                      _buildLegend(Colors.red, 'Full Day Leave'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegend(Colors.orange, 'Holiday'),
                      _buildLegend(Colors.blue, 'Attendance Not Marked'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.power_settings_new), label: 'Logout'),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
