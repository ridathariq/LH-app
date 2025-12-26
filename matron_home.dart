import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/matron-homescreens/matron-homegoing.dart';
import 'package:app/matron-homescreens/matron-outgoing.dart';
import 'package:app/matron-homescreens/matron_attendance.dart';
import 'package:app/matron-homescreens/matron_complaint.dart';

class MatronHomePage extends StatefulWidget {
  final String matronName;
  final String matronRegNo;
  final String matronImage;

  const MatronHomePage({
    Key? key,
    required this.matronName,
    required this.matronRegNo,
    required this.matronImage,
  }) : super(key: key);

  @override
  _MatronHomePageState createState() => _MatronHomePageState();
}

class _MatronHomePageState extends State<MatronHomePage> {
  late Future<List> complaintsFuture;
  late Future<List> homegoingRequestsFuture;
  late Future<List> outgoingRequestsFuture;

  @override
  void initState() {
    super.initState();
    complaintsFuture = fetchComplaints();
    homegoingRequestsFuture = fetchHomegoingRequests();
    outgoingRequestsFuture = fetchOutgoingRequests();
  }

  Future<List> fetchComplaints() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:3000/complaints/Matron"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load complaints");
      }
    } catch (e) {
      print("Error fetching complaints: $e");
      return [];
    }
  }

  Future<List> fetchHomegoingRequests() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:3000/homegoing/requests"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load homegoing requests");
      }
    } catch (e) {
      print("Error fetching homegoing requests: $e");
      return [];
    }
  }

  Future<List> fetchOutgoingRequests() async {
    try {
      final response = await http.get(Uri.parse("http://localhost:3000/outgoing/requests"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load outgoing requests");
      }
    } catch (e) {
      print("Error fetching outgoing requests: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Matron Dashboard"),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.matronImage),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 10),
            Text(
              "Hi, ${widget.matronName}!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 5),
            Text(
              widget.matronRegNo,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Dashboard Options
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: [
                buildComplaintTile(context),
                buildAttendanceTile(context),
                buildHomegoingTile(context),
                buildOutgoingTile(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildComplaintTile(BuildContext context) {
    return FutureBuilder<List>(
      future: complaintsFuture,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasData
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintListScreen(complaints: snapshot.data!),
                    ),
                  )
              : null,
          child: buildTile(Icons.feedback, "View Complaints", Color(0xFFF65A38)),
        );
      },
    );
  }

  Widget buildAttendanceTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Mocked Room Data, Replace with actual room and students fetching logic
        List<Map<String, dynamic>> students = [
          {"registernumber": "1001", "name": "John Doe"},
          {"registernumber": "1002", "name": "Jane Smith"},
        ];
        String roomName = "Room A1";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttendanceApp(),
          ),
        );
      },
      child: buildTile(Icons.checklist, "Mark Attendance", Color(0xFF4CAF50)),
    );
  }

  Widget buildHomegoingTile(BuildContext context) {
    return FutureBuilder<List>(
      future: homegoingRequestsFuture,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasData
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatronHomegoingScreen(homegoingRequests: snapshot.data!),
                    ),
                  )
              : null,
          child: buildTile(Icons.home, "Homegoing Requests", Color(0xFF1E1E1E)),
        );
      },
    );
  }

  Widget buildOutgoingTile(BuildContext context) {
    return FutureBuilder<List>(
      future: outgoingRequestsFuture,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: snapshot.hasData
              ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatronOutgoingScreen(outgoingRequests: snapshot.data!),
                    ),
                  )
              : null,
          child: buildTile(Icons.exit_to_app, "Outgoing Requests", Color(0xFF2196F3)),
        );
      },
    );
  }

  Widget buildTile(IconData icon, String title, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC8E3C7), width: 2),
        color: const Color(0xFFEAF4E2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: iconColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
