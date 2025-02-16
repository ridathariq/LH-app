
import 'package:flutter/material.dart';
import 'package:ladiesapp/screen/login.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 2,
        title: const Text(
          "Who Are You?",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUserOption(context, "Student", Icons.school),
            const SizedBox(height: 20),
            _buildUserOption(context, "Office", Icons.business),
            const SizedBox(height: 20),
            _buildUserOption(context, "Matron", Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildUserOption(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Navigate to login page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenLogin()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: const Color(0xFFF65A38)),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}