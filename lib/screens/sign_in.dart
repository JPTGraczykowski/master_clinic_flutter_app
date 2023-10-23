import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../screens/doctor/doctor_dashboard.dart';
import '../../screens/patient/patient_dashboard.dart';
import '../../utils/api_helper.dart';
import '../../widgets/overlay_widget.dart';
import '../../widgets/primary_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String _error = '';

  void saveAuthorizationTokenInStorage(String token) async {
    await storage.write(key: 'authorization_token', value: token);
  }

  void saveUserInState(Response response) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    String id = responseData['id'].toString();
    UserRole role = UserRole.values.byName(responseData['role']);

    User user = User(
      id: id,
      role: role,
      email: responseData['email'],
      firstName: responseData['first_name'],
      lastName: responseData['last_name'],
      telephone: responseData['telephone'],
      active: responseData['active'],
    );
  }

  void onSignIn(BuildContext context) async {
    context.loaderOverlay.show();
    setState(() {
      _isLoading = true;
    });
    final String url = ApiHelper.authLogin();
    Map<String, Map<String, String>> body = {
      "user": {
        "email": _email,
        "password": _password,
      }
    };

    try {
      final response = await ApiHelper.sendPostRequest(url, body);

      if (response == null) {
        onFailureSignIn(context);
        return;
      }

      Map<String, dynamic> responseData = response.data;
      String token = response.headers['authorization'] as String;

      onSuccessfulSignIn(context, responseData, token);
    } catch (error) {
      print(error);
      onFailureSignIn(context);
    }
  }

  void onSuccessfulSignIn(BuildContext context, Map<String, dynamic> responseData, String token) async {
    String id = responseData['id'].toString();
    UserRole role = UserRole.values.byName(responseData['role']);

    saveAuthorizationTokenInStorage(token);
    // saveUserAttributesInStorage(id, role);

    Widget dashboard =
        role == UserRole.doctor || role == UserRole.admin ? DoctorDashboardScreen() : PatientDashboardScreen();

    _isLoading = false;
    context.loaderOverlay.hide();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => dashboard),
    );
  }

  void onFailureSignIn(BuildContext context) {
    setState(() {
      _error = 'Something went wrong. Please try again later.';
      _isLoading = false;
      context.loaderOverlay.hide();
    });
  }

  InputDecoration loginInputDecoration({
    required String label,
  }) =>
      InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(borderSide: BorderSide()),
        labelText: label,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        overlayWidget: OverlayWidget(),
        overlayColor: Theme.of(context).colorScheme.background,
        overlayOpacity: 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 128.0,
            horizontal: 32.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Master Clinic',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Text(
                'Please sign in',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              SizedBox(height: 64.0),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: loginInputDecoration(label: 'e-mail'),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                decoration: loginInputDecoration(label: 'password'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              SizedBox(
                height: 32.0,
              ),
              PrimaryButton(
                onPressed: () {
                  onSignIn(context);
                },
                content: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
