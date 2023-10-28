import 'package:flutter/material.dart';
import 'package:planets/ui/planets_screen.dart';


void main() => runApp(const PlanetsApp());

class PlanetsApp extends StatelessWidget {
  const PlanetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlanetsScreen(),
    );
  }
}
