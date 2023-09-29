import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

  void onSignIn(BuildContext context) async {
    context.loaderOverlay.show();
    setState(() {
      _isLoading = true;
    });
    final Uri url = ApiHelper.authLogin;

    Map<String, Map<String, String>> body = {
      "user": {
        "email": _email,
        "password": _password,
      }
    };

    try {
      final response = await ApiHelper.sendPostRequest(url, body);

      if (response.statusCode >= 400) {
        setState(() {
          onFailureSignIn(context);
          return;
        });
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      _isLoading = false;
      context.loaderOverlay.hide();
      print(responseData);
    } catch (error) {
      print(error);
      onFailureSignIn(context);
    }
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
                'Please sing in',
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
