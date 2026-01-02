import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/student-homescreens/outgoing.dart';

class OutgoingRequestsScreen extends StatefulWidget {
  final String registernumber;

  const OutgoingRequestsScreen({Key? key, required this.registernumber}) : super(key: key);

  @override
  _OutgoingRequestsScreenState createState() => _OutgoingRequestsScreenState();
}

class _OutgoingRequestsScreenState extends State<OutgoingRequestsScreen> {
  List<Map<String, dynamic>> outgoingRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOutgoingRequests();
  }

  Future<void> fetchOutgoingRequests() async {
    final String apiUrl = "http://localhost:3000/outgoing/requests/${widget.registernumber}";

    try {
      print("Fetching requests from: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);
        print("Decoded Response: $decodedData");

        setState(() {
          outgoingRequests = List<Map<String, dynamic>>.from(decodedData);
          isLoading = false;
        });

        print("Outgoing Requests Loaded: $outgoingRequests");
      } else {
        setState(() {
          outgoingRequests = [];
          isLoading = false;
        });
        print("Failed to fetch requests: ${response.body}");
      }
    } catch (e) {
      print("Error fetching requests: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text("Outgoing Requests"),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: outgoingRequests.isEmpty
                      ? Center(child: Text("No previous requests found."))
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: outgoingRequests.length,
                          itemBuilder: (context, index) {
                            final request = outgoingRequests[index];

                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  "Place: ${request['place'] ?? 'N/A'}\nGoing Time: ${request['goingTime'] ?? 'N/A'} - Return Time: ${request['reachBackTime'] ?? 'N/A'}",
                                ),
                                subtitle: Text(
                                  "Register Number: ${request['registernumber'] ?? 'N/A'}\nStatus: ${request['status'] ?? 'Pending'}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OutGoingScreen(registernumber: widget.registernumber),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF65A38),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Request New Outgoing",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
