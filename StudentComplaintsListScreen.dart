import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/student-homescreens/complaint.dart'; // Ensure correct import path

class StudentComplaintsListScreen extends StatefulWidget {
  final String studentRegNo;
  final String studentName;

  StudentComplaintsListScreen({required this.studentRegNo, required this.studentName});

  @override
  _StudentComplaintsListScreenState createState() => _StudentComplaintsListScreenState();
}

class _StudentComplaintsListScreenState extends State<StudentComplaintsListScreen> {
  List<dynamic> _complaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    var url = Uri.parse("http://localhost:3000/complaints/student/${widget.studentRegNo}");
    
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _complaints = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load complaints");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FD), // Background color
      appBar: AppBar(
        title: Text("My Complaints"),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _complaints.isEmpty
              ? Center(child: Text("No complaints found"))
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: _complaints.length,
                  itemBuilder: (context, index) {
                    var complaint = _complaints[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      color: Color(0xFFEAF4E2), // Light greenish background
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(complaint["complaintText"], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("Status: ${complaint["status"]}", style: TextStyle(color: Colors.grey[700])),
                        trailing: Icon(
                          complaint["status"] == "Resolved" ? Icons.check_circle : Icons.hourglass_empty,
                          color: complaint["status"] == "Resolved" ? Colors.green : Colors.orange,
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF65A38), // Orange color
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentComplaintScreen(
                studentRegNo: widget.studentRegNo, // FIXED: Added widget.
                studentName: widget.studentName, // FIXED: Added widget.
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
