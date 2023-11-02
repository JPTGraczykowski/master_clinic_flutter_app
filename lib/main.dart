import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/sign_in.dart';
import '../../screens/doctor/doctor_dashboard.dart';
import '../../screens/patient/patient_dashboard.dart';
import 'models/user.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 150, 230, 250),
  ),
);

final storage = FlutterSecureStorage();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<String>> get authData async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await storage.read(key: 'authorization_token');
    String? userId = prefs.getString('user_id');
    String? userRole = prefs.getString('user_role');

    if (token != null && userId != null && userRole != null) {
      return [token, userId, userRole];
    }

    return [];
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Master Clinic',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: snackbarKey,
        theme: theme,
        home: FutureBuilder(
          future: authData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data!.length == 3) {
              String token = snapshot.data![0];
              String userRole = snapshot.data![2];

              List<String> splitToken = token.split('.');

              if (splitToken.length != 3) return SignInScreen();

              dynamic tokenPayload = json.decode(
                ascii.decode(
                  base64.decode(
                    base64.normalize(splitToken[1]),
                  ),
                ),
              );

              bool tokenIsUpToDate =
                  DateTime.fromMillisecondsSinceEpoch(tokenPayload["exp"] * 1000).isAfter(DateTime.now());

              if (tokenIsUpToDate) {
                UserRole role = UserRole.values.byName(userRole);

                if (role == UserRole.doctor || role == UserRole.admin) {
                  return DoctorDashboardScreen();
                } else if (role == UserRole.patient) {
                  return PatientDashboardScreen();
                }
                return SignInScreen();
              }
              return SignInScreen();
            }
            return SignInScreen();
          },
        ));
  }
}
