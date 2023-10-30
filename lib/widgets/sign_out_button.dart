import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../screens/sign_in.dart';
import '../../utils/api_helper.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  void onSignOut(BuildContext context) async {
    final String url = ApiHelper.authLogout();

    final response = await ApiHelper.sendDeleteRequest(url);

    if (response == null) {
      return;
    }
    onSuccessfulSignOut(context);
  }

  void onSuccessfulSignOut(BuildContext context) {
    removeTokenFromStorage();
    removeUserFromState();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  void removeTokenFromStorage() async {
    await storage.delete(key: 'authorization_token');
  }

  void removeUserFromState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_role');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OutlinedButton(
        onPressed: () {
          onSignOut(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_outlined),
            Text('Sign Out'),
          ],
        ),
      ),
    );
  }
}
