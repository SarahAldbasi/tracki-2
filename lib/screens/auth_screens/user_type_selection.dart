import 'package:flutter/material.dart';
import 'package:restaurant/screens/auth_screens/sign_up.dart';
import 'package:restaurant/utils/app_colors.dart';

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF674188),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('يرجى اختيار نوع الحساب', // Prompt in Arabic
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF674188),
                )),
            const SizedBox(height: 40.0),
            SizedBox(
              width: 200, // Fixed width for the button
              height: 50, // Fixed height for the button
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SignUpScreen(), // Navigate to Customer Sign Up
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white, //
                  textStyle: const TextStyle(fontSize: 20), // Text style
                ),
                child: const Text('زبون'), // Button text for Customer
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
