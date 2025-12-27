import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentComplaintScreen extends StatefulWidget {
  final String studentRegNo;
  final String studentName;

  StudentComplaintScreen({required this.studentRegNo, required this.studentName});

  @override
  _StudentComplaintScreenState createState() => _StudentComplaintScreenState();
}

class _StudentComplaintScreenState extends State<StudentComplaintScreen> {
  final TextEditingController _complaintController = TextEditingController();
  String _selectedRecipient = "Warden"; // Default selection

  Future<void> _submitComplaint() async {
    String complaintText = _complaintController.text.trim();
    if (complaintText.isEmpty) return;

    var url = Uri.parse("http://localhost:3000/complaints/submit");
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "studentRegNo": widget.studentRegNo, 
          "studentName": widget.studentName, 
          "recipient": _selectedRecipient, 
          "complaintText": complaintText, 
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Complaint sent successfully!"), backgroundColor: Colors.green),
        );
        _complaintController.clear(); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send complaint"), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige Background
      appBar: AppBar(
        title: Text("Submit Complaint"),
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recipient", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFEAF4E2), 
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: _selectedRecipient,
                isExpanded: true,
                underline: SizedBox(),
                items: ["Warden", "Matron"].map((String recipient) {
                  return DropdownMenuItem<String>(
                    value: recipient,
                    child: Text(recipient, style: TextStyle(color: Color(0xFF1E1E1E))),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedRecipient = newValue!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _complaintController,
              decoration: InputDecoration(
                labelText: "Enter your complaint",
                border: OutlineInputBorder(),
                fillColor: Color(0xFFEAF4E2),
                filled: true,
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitComplaint,
                child: Text("Submit Complaint"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF65A38), // Orange
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
