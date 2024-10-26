import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'package:restaurant/utils/app_colors.dart';

class RequestPage2 extends StatelessWidget {
  const RequestPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Lottie Animation
            Lottie.asset(
              'lib/assets/reject.json', // Error animation URL
              width: 150,
              height: 150,
              repeat: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'نعتذر منك',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'طلبك مرفوض',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
