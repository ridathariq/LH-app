
import 'package:app/screens/userselection.dart';
import 'package:flutter/material.dart';

class ScreenGetStarted extends StatelessWidget {
  const ScreenGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Welcome Text
              const Text(
                "Welcome to Our App!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF65A38), // Orange
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              const Text(
                "Get started now and experience a hassle-free hostel life!",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E1E1E), // Dark Charcoal
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSelectionScreen(), // Navigates to login page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 18, color: Color(0xFFEAF4E2)), // Mint Green
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
