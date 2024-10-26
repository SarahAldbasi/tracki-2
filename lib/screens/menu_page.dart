import 'package:flutter/material.dart';
import 'package:restaurant/screens/request_pages/request_page1.dart';
import 'package:restaurant/screens/request_pages/request_page2.dart';
import 'package:restaurant/screens/request_pages/request_page3.dart';
import 'package:restaurant/utils/app_colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        title: const Text(" الملف الشخصي"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Button for Request 1
            _buildCircleButton(
              text: 'Req 1',
              onTap: () {
                _navigateToRequestPage(context, const RequestPage1());
              },
            ),
            const SizedBox(height: 20),
            // Circular Button for Request 2
            _buildCircleButton(
              text: 'Req 2',
              onTap: () {
                _navigateToRequestPage(context, const RequestPage2());
              },
            ),
            const SizedBox(height: 20),
            // Circular Button for Request 3
            _buildCircleButton(
              text: 'Req 3',
              onTap: () {
                _navigateToRequestPage(context, const RequestPage3());
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create circular buttons
  Widget _buildCircleButton(
      {required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryLight,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Navigation method
  void _navigateToRequestPage(BuildContext context, Widget requestPage) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => requestPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // From right to left transition
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
