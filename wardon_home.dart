import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomePage3 extends StatefulWidget {
  final String token; // Specify type

  const HomePage3({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage3> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage3> {
  late String registernumber;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    registernumber = jwtDecodedToken['registernumber'] ?? 'Unknown registernumber'; // Handle missing email key
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wardon Home")),
      body: Center( // Removed 'const' because email is a runtime value
        child: Text(
          registernumber,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}