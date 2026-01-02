import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OutGoingScreen extends StatefulWidget {
  final String registernumber;

  const OutGoingScreen({Key? key, required this.registernumber}) : super(key: key);

  @override
  _OutGoingScreenState createState() => _OutGoingScreenState();
}

class _OutGoingScreenState extends State<OutGoingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _leavingTimeController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _reachingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  // Fetch student details from API
  Future<void> fetchStudentDetails() async {
    final String apiUrl = "http://localhost:3000/outgoing/student-details/${widget.registernumber}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      print("Student Details Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _nameController.text = data['name'] ?? "";
          _roomController.text = data['roomno'] ?? "";
        });
      } else {
        print("Failed to fetch student details: ${response.body}");
      }
    } catch (e) {
      print("Error fetching student details: $e");
    }
  }

  // Submit outgoing request to API
  Future<void> submitOutgoingRequest() async {
    final String apiUrl = "http://localhost:3000/outgoing/submit";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
  "registernumber": widget.registernumber,
  "goingTime": _leavingTimeController.text, 
  "place": _placeController.text,
  "reachBackTime": _reachingTimeController.text,
}),

      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Outgoing request submitted successfully")),
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
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 2,
        title: const Text(
          "Outgoing Request",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(label: "Name", controller: _nameController, readOnly: true),
              const SizedBox(height: 16),
              _buildTextField(label: "Room No.", controller: _roomController, readOnly: true),
              const SizedBox(height: 16),
              _buildTextField(label: "Leaving Time", controller: _leavingTimeController),
              const SizedBox(height: 16),
              _buildTextField(label: "Place", controller: _placeController),
              const SizedBox(height: 16),
              _buildTextField(label: "Reaching Back Time", controller: _reachingTimeController),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitOutgoingRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF65A38),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Submit Outgoing Request",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEAF4E2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
        ),
      ],
    );
  }
}
