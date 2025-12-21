import 'package:flutter/material.dart';

class ComplaintListScreen extends StatelessWidget {
  final List complaints;

  const ComplaintListScreen({Key? key, required this.complaints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige Background
      appBar: AppBar(
        title: const Text("Complaints"),
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
      ),
      body: complaints.isEmpty
          ? const Center(
              child: Text(
                "No complaints found",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                var complaint = complaints[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color(0xFFEAF4E2), // Mint Green
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      complaint['studentName'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          complaint['complaintText'],
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Date: ${complaint['date'] ?? 'Not Available'}",
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    leading: const Icon(Icons.report_problem, color: Color(0xFFF65A38), size: 30), // Orange Icon
                  ),
                );
              },
            ),
    );
  }
}
