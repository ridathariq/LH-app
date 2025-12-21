import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RoomSelectionScreen(),
    );
  }
}

class RoomSelectionScreen extends StatefulWidget {
  @override
  _RoomSelectionScreenState createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  List<String> rooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    final response = await http.get(Uri.parse('http://localhost:3000/attendance/rooms'));
    if (response.statusCode == 200) {
      setState(() {
        rooms = List<String>.from(json.decode(response.body));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Room')),
      body: ListView(
        children: rooms.map((room) => roomButton(context, room)).toList(),
      ),
    );
  }

  Widget roomButton(BuildContext context, String roomName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttendanceScreen(roomName: roomName),
          ),
        );
      },
      child: Text(roomName),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  final String roomName;

  AttendanceScreen({required this.roomName});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> students = [];
  Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final response = await http.get(Uri.parse('http://localhost:3000/attendance/students/${widget.roomName}'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        students = data.cast<Map<String, dynamic>>();
        attendance = {for (var student in students) student["registernumber"]: true};
      });
    }
  }

  void toggleAttendance(String registernumber) {
    setState(() {
      attendance[registernumber] = !attendance[registernumber]!;
    });
  }

  Future<void> submitAttendance() async {
    final url = Uri.parse('http://localhost:3000/attendance/mark');
    final body = jsonEncode({
      "roomno": widget.roomName,
      "students": students.map((student) => {
        "registernumber": student["registernumber"],
        "name": student["name"], 
        "isPresent": attendance[student["registernumber"]] ?? true
      }).toList()
    });

    await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Attendance Submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.roomName} - Attendance')),
      body: ListView(
        children: students.map((student) {
          bool isPresent = attendance[student["registernumber"]]!;
          return ListTile(
            title: Text(student["name"]),
            tileColor: isPresent ? Colors.green[100] : Colors.red[200],
            onTap: () => toggleAttendance(student["registernumber"]),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: submitAttendance,
        child: Icon(Icons.check),
      ),

      
    );
  }
}

