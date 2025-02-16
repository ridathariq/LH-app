
import 'package:flutter/material.dart';
import 'package:ladiesapp/screen/attendence.dart';
import 'package:ladiesapp/screen/complaint.dart';
import 'package:ladiesapp/screen/food%20preference.dart';
import 'package:ladiesapp/screen/homegoing.dart';
import 'package:ladiesapp/screen/messcut.dart';
import 'package:ladiesapp/screen/notice.dart';
import 'package:ladiesapp/screen/outgoing.dart';
import 'package:ladiesapp/screen/permission.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige Background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
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
            const Text(
              "Hi, Jenifer!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 5),
            const Text(
              "Register Number",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("View all", style: TextStyle(color: Color(0xFFF65A38))), // Orange
                )
              ],
            ),
            const SizedBox(height: 10),
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
                buildProjectCard("Permisssion Request", Icons.verified_user, context),
                buildProjectCard("complaint", Icons.feedback, context),

              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF65A38), // Orange
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttendanceScreen()),
          );
        }
        if (title == "Notice Board") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoticeBoardScreen()),
          );
        }
         if (title == "Food Preference") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FoodRequirementScreen()),
          );
        }
        if (title == "Home Going") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeGoingScreen() ),
          );
        }
        if (title == "Out Going") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OutGoingScreen() ),
          );
        }
         if (title == "Permisssion Request") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PermissionScreen()),
          );
        }
        if (title == "complaint") {

       Navigator.push(
        context,
       MaterialPageRoute(builder: (context) => ComplaintScreen()), // Navigate to OutGoingScreen

        );

}
if (title == "Mess Cut") {

Navigator.push(

context,

MaterialPageRoute(builder: (context) => MessCutScreen()), // Navigate to OutGoingScreen

);

}
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC8E3C7), width: 2), // Light Green
          color: const Color(0xFFEAF4E2), // Mint Green
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFFF65A38)), // Orange
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)), // Dark Charcoal
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
