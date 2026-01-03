import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileScreen extends StatefulWidget {
  final String token;

  const ProfileScreen({Key? key, required this.token}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String name;
  late String registernumber;
  late String roomNumber;
  late String place;

  @override
  void initState() {
    super.initState();
    _decodeToken();
  }

  void _decodeToken() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);

    setState(() {
      name = decodedToken['name'] ?? 'Unknown';
      registernumber = decodedToken['registernumber'] ?? 'N/A';
      roomNumber = decodedToken['roomno'] ?? 'N/A';
      place = decodedToken['place'] ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Profile Picture with Card
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage('assets/profile_image.png'), // Use Network Image if needed
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // User Details Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  buildDetailRow("Name", name),
                  buildDetailRow("Register No", registernumber),
                  buildDetailRow("Room No", roomNumber),
                  buildDetailRow("Home Location", place),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () {
                  // Implement logout functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF65A38), // Orange
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFEAF4E2), // Mint Green
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // User Details in Row
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1E1E), // Dark Charcoal
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
