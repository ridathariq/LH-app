import 'package:app/student-homescreens/StudentComplaintsListScreen.dart';
import 'package:app/student-homescreens/attendence.dart';
import 'package:app/student-homescreens/complaint.dart';
import 'package:app/student-homescreens/food%20preference.dart';
import 'package:app/student-homescreens/homegoing.dart';
import 'package:app/student-homescreens/homegoingrequest.dart';
import 'package:app/student-homescreens/messcut.dart';
import 'package:app/student-homescreens/notice.dart';
import 'package:app/student-homescreens/outgoing.dart';
import 'package:app/student-homescreens/outgoingrequest.dart';
import 'package:app/student-homescreens/permission.dart';
import 'package:app/student-homescreens/profile.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomePage1 extends StatefulWidget {
  final String token; // JWT Token

  const HomePage1({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  late String registernumber;
  late String username; // Store decoded username

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    registernumber = jwtDecodedToken['registernumber'] ?? 'Unknown Register No';
    username = jwtDecodedToken['name'] ?? 'User'; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_2, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(token: widget.token),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_image.png'),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 10),
            Text(
              "Hi, $username!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 5),
            Text(
              registernumber,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: [
                buildProjectCard("Attendance", Icons.checklist, context),
                buildProjectCard("Food Preference", Icons.restaurant, context),
                buildProjectCard("Mess Cut", Icons.cut, context),
                buildProjectCard("Notice Board", Icons.notifications_none_outlined, context),
                buildProjectCard("Home Going", Icons.home_filled, context),
                buildProjectCard("Out Going", Icons.directions_run, context),
                buildProjectCard("Permission", Icons.verified_user, context),
                buildProjectCard("Complaint", Icons.feedback, context),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF65A38),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        ],
      ),
    );
  }

  Widget buildProjectCard(String title, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Attendance") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen(registernumber: registernumber)));
        }
        if (title == "Notice Board") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeBoardScreen()));
        }
        if (title == "Food Preference") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FoodRequirementScreen()));
        }
        if (title == "Home Going") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomegoingRequestsScreen(registernumber: registernumber)));
        }
        if (title == "Out Going") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OutgoingRequestsScreen(registernumber: registernumber)));
        }
        if (title == "Permission") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionScreen()));
        }
        if (title == "Complaint") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentComplaintsListScreen(studentRegNo: registernumber, studentName:  username)
            ),
          );
        }
        if (title == "Mess Cut") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MessCutScreen()));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC8E3C7), width: 2),
          color: const Color(0xFFEAF4E2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFF65A38)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}