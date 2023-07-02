import 'package:flutter/material.dart';

import 'package:master_clinic_flutter_app/screens/doctor_dashboard.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 150, 230, 250),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Clinic',
      theme: theme,
      home: const DoctorDashboardScreen(),
    );
  }
}
