import 'package:flutter/material.dart';

class MatronOutgoingScreen extends StatelessWidget {
  final List outgoingRequests;

  const MatronOutgoingScreen({Key? key, required this.outgoingRequests}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text("Outgoing Requests"),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: outgoingRequests.isEmpty
          ? const Center(
              child: Text(
                "No outgoing requests found.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: outgoingRequests.length,
              itemBuilder: (context, index) {
                var request = outgoingRequests[index];
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
                        Text("Place: ${request['place']}"),
                        Text("Going Time: ${request['goingTime']}"),
                        Text("Return Time: ${request['reachBackTime']}"),
                      ],
                    ),
                    leading: const Icon(Icons.exit_to_app, color: Color(0xFF2196F3)),
                  ),
                );
              },
            ),
    );
  }
}


