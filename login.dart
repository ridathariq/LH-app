import 'package:app/screens/matron_home.dart';
import 'package:app/screens/student_home.dart';
import 'package:app/screens/wardon_home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart'; // Ensure this contains your API URLs

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController registernumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;
  bool _isLoading = false;
  String? _errorMessage;
    bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  void _loadUserRole() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    var reqBody = {
      "registernumber": registernumberController.text.trim(),
      "password": passwordController.text.trim(),
    };

    try {
      var response = await http.post(
        Uri.parse(Login), // Ensure "Login" is properly defined in config.dart
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var myToken = jsonResponse['token'];
        var role = jsonResponse['role'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', myToken);
        await prefs.setString('role', role);

        Widget homeScreen;

        if (role == "student") {
          homeScreen = HomePage1(token: myToken);
        } else if (role == "matron") {
          String matronName = jsonResponse['matronName'] ?? 'Matron';
          String matronRegNo = jsonResponse['matronRegNo'] ?? 'N/A';
          String matronImage = jsonResponse['matronImage'] ?? '';

          homeScreen = MatronHomePage(
            matronName: matronName,
            matronRegNo: matronRegNo,
            matronImage: matronImage,
          );
        } else {
          homeScreen = HomePage3(token: myToken);
        }

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeScreen));
      } else {
        setState(() {
          _errorMessage = "Invalid register number or password";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Login failed. Please check your connection.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FD), // Off-White/Beige
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Soft shadow
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF65A38), // Orange
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Login to continue",
                      style: TextStyle(fontSize: 16, color: Color(0xFF1E1E1E)), // Dark Charcoal
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registernumberController,
                      decoration: InputDecoration(
                        labelText: "Register Number",
                        prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFF65A38)), // Orange
                        filled: true,
                        fillColor: const Color(0xFFEAF4E2), // Mint Green
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                  // Add this variable to the state

TextField(
  controller: passwordController,
  obscureText: _obscureText, // Use the state variable here
  decoration: InputDecoration(
    labelText: "Password",
    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFF65A38)), // Orange
    suffixIcon: GestureDetector(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText; // Toggle visibility
        });
      },
      child: Icon(
        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, 
        color: Color(0xFFF65A38), // Orange
      ),
    ),
    filled: true,
    fillColor: const Color(0xFFEAF4E2), // Mint Green
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16),
  ),
),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFF65A38)), // Orange
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.check, size: 18, color: Color(0xFFF65A38)), // Orange
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Remember Me",
                                style: TextStyle(color: Color(0xFF1E1E1E)), // Dark Charcoal
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color(0xFFF65A38)), // Orange
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF65A38), // Orange
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _login,
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
