import 'package:flutter/material.dart';
import 'package:integrate_api/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest Apis integration',
      theme: ThemeData(fontFamily: 'Monsterrat'),
      home: const DashboardPage(),
    );
  }
}
