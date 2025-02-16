import 'package:flutter/material.dart';

class FoodRequirementScreen extends StatefulWidget {
  @override
  _FoodRequirementScreenState createState() => _FoodRequirementScreenState();
}

class _FoodRequirementScreenState extends State<FoodRequirementScreen> {
  String? foodRequired; // Yes or No selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food Requirement",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF1E1E1E), // Orange
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xFFEAF4E2), // Mint Green
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.fastfood, color: Color(0xFF1E1E1E)), // Dark Charcoal
                  SizedBox(width: 10),
                  Text(
                    "Do you require food today?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E), // Dark Charcoal
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text(
                    "Yes, I need food today",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E), // Dark Charcoal
                    ),
                  ),
                  value: "Yes",
                  groupValue: foodRequired,
                  activeColor: Color(0xFFF65A38), // Orange
                  onChanged: (value) {
                    setState(() {
                      foodRequired = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    "No, I don’t need food today",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E1E1E), // Dark Charcoal
                    ),
                  ),
                  value: "No",
                  groupValue: foodRequired,
                  activeColor: Color(0xFFF65A38), // Orange
                  onChanged: (value) {
                    setState(() {
                      foodRequired = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF65A38), // Orange
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        foodRequired == "Yes"
                            ? "Food request submitted!"
                            : "No food required today.",
                      ),
                      backgroundColor: Color(0xFF1E1E1E), // Dark Charcoal
                    ),
                  );
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
