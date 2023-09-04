import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:master_clinic_flutter_app/widgets/primary_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late String _email;
  late String _password;
  bool _isSaving = false;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 128.0,
            horizontal: 32.0,
          ),
          child: Column(
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
              ),
              SizedBox(
                height: 32.0,
              ),
              PrimaryButton(
                onPressed: _isSaving ? null : () {},
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
