import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentHomegoing extends StatefulWidget {
  final String registernumber;

  const StudentHomegoing({Key? key, required this.registernumber}) : super(key: key);

  @override
  _StudentHomegoingState createState() => _StudentHomegoingState();
}

class _StudentHomegoingState extends State<StudentHomegoing> {
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController goingDateController = TextEditingController();
  TextEditingController comingDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    final String apiUrl = "http://localhost:3000/homegoing/student-details/${widget.registernumber}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      print("Student Details Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          nameController.text = data['name'] ?? "";
          placeController.text = data['place'] ?? "";
          roomController.text = data['roomno'] ?? "";
          phoneController.text = data['phno'] ?? "";
        });
      } else {
        print("Failed to fetch student details: ${response.body}");
      }
    } catch (e) {
      print("Error fetching student details: $e");
    }
  }

  Future<void> submitHomegoingRequest() async {
    final String apiUrl = "http://localhost:3000/homegoing/submit";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "registernumber": widget.registernumber,
          "goingDate": goingDateController.text,
          "comingDate": comingDateController.text
        }),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Homegoing request submitted successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit request: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Homegoing Form"),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField(nameController, "Name", readOnly: true),
            buildTextField(placeController, "Place", readOnly: true),
            buildTextField(roomController, "Room No", readOnly: true),
            buildTextField(phoneController, "Phone No", readOnly: true),
            buildTextField(goingDateController, "Going Date"),
            buildTextField(comingDateController, "Coming Date"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitHomegoingRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF65A38),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  "Submit Homegoing Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
