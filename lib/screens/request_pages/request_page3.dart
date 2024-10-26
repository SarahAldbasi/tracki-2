import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'package:restaurant/utils/app_colors.dart';

class RequestPage3 extends StatelessWidget {
  const RequestPage3({super.key});

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
            // Loading/Pending Lottie Animation
            Lottie.asset(
              'lib/assets/success.json', // Pending animation URL
              width: 150,
              height: 150,
              repeat: true, // Repeat for pending
            ),
            const SizedBox(height: 20),
            const Text(
              'شكرا لك',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'تم ارسال الطلب',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '… طلبك حاليا قيد الانتظار',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
