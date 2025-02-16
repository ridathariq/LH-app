import 'package:flutter/material.dart';

class MessCutScreen extends StatefulWidget {
  const MessCutScreen({super.key});

  @override
  _MessCutScreenState createState() => _MessCutScreenState();
}

class _MessCutScreenState extends State<MessCutScreen> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mess Cut Request"),
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select the period of absence (Minimum 5 days required)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Start Date Picker
            ListTile(
              title: Text(startDate == null ? "Select Start Date" : "Start Date: ${startDate!.toLocal()}".split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024, 1, 1),
                  lastDate: DateTime(2025, 12, 31),
                );
                if (picked != null) {
                  setState(() {
                    startDate = picked;
                  });
                }
              },
            ),

            // End Date Picker
            ListTile(
              title: Text(endDate == null ? "Select End Date" : "End Date: ${endDate!.toLocal()}".split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: startDate ?? DateTime.now(),
                  firstDate: startDate ?? DateTime(2024, 1, 1),
                  lastDate: DateTime(2025, 12, 31),
                );
                if (picked != null) {
                  setState(() {
                    endDate = picked;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (startDate != null && endDate != null) {
                    int daysAbsent = endDate!.difference(startDate!).inDays + 1;
                    if (daysAbsent >= 5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mess Cut Approved for $daysAbsent days!"),
                          backgroundColor: const Color(0xFFF65A38), // Orange
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Minimum 5 days required for mess cut."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select start and end dates."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF65A38), // Orange
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}