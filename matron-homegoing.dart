import 'package:flutter/material.dart';

class MatronHomegoingScreen extends StatelessWidget {
  final List homegoingRequests;

  const MatronHomegoingScreen({Key? key, required this.homegoingRequests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Homegoing Requests"),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: homegoingRequests.isEmpty
          ? const Center(
              child: Text(
                "No homegoing requests found.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: homegoingRequests.length,
              itemBuilder: (context, index) {
                var request = homegoingRequests[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: const Color(0xFFEAF4E2),
                  child: ListTile(
                    title: Text(
                      "${request['name']} - Room ${request['roomNo']}",
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Going: ${request['goingDate']}"),
                        Text("Returning: ${request['comingDate']}"),
                        Text("Place: ${request['place']}"),
                        Text("Phone: ${request['phoneNumber']}"),
                      ],
                    ),
                    leading: const Icon(Icons.directions_bus, color: Color(0xFFF65A38)),
                  ),
                );
              },
            ),
    );
  }
}
