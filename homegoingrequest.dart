import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/student-homescreens/homegoing.dart';

class HomegoingRequestsScreen extends StatefulWidget {
  final String registernumber;

  const HomegoingRequestsScreen({Key? key, required this.registernumber}) : super(key: key);

  @override
  _HomegoingRequestsScreenState createState() => _HomegoingRequestsScreenState();
}

class _HomegoingRequestsScreenState extends State<HomegoingRequestsScreen> {
  List<Map<String, dynamic>> homegoingRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHomegoingRequests();
  }

  Future<void> fetchHomegoingRequests() async {
    final String apiUrl = "http://localhost:3000/homegoing/requests/${widget.registernumber}";

    try {
      print("Fetching requests from: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(response.body);
        print("Decoded Response: $decodedData");

        setState(() {
          homegoingRequests = List<Map<String, dynamic>>.from(decodedData);
          isLoading = false;
        });

        print("Homegoing Requests Loaded: $homegoingRequests");
      } else {
        setState(() {
          homegoingRequests = [];
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
        title: Text("Homegoing Requests"),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: homegoingRequests.isEmpty
                      ? Center(child: Text("No previous requests found."))
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: homegoingRequests.length,
                          itemBuilder: (context, index) {
                            final request = homegoingRequests[index];

                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  "Going: ${request['goingDate'] ?? 'N/A'} - Coming: ${request['comingDate'] ?? 'N/A'}",
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
                          builder: (context) => StudentHomegoing(registernumber: widget.registernumber),
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
                        "Request New Homegoing",
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
