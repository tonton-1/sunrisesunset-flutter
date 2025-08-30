import 'package:flutter/material.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.kanitTextTheme()),
      home: Scaffold(
        backgroundColor: Color.fromARGB(232, 255, 255, 255),
        body: const Center(child: Homepage()),
      ),
    );
  }
}
