import 'package:flutter/material.dart';
import 'package:restaurant/utils/app_colors.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomNavbar(
      {super.key, required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          bottom: 10,
          left: 20,
          right: 20), // Adds margin for the floating effect
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(30), // Rounded corners for floating effect
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow for floating effect
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: BottomAppBar(
          // shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          elevation: 8, // Slight elevation to give a floating look
          color: AppColors.primaryDark,
          child: SizedBox(
            height: 60, // Height of the navbar
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavItem(Icons.home, 'Home', 0),
                _buildNavItem(Icons.favorite, 'Favorites', 1),
                _buildNavItem(Icons.map_sharp, 'Map', 2),
                _buildNavItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentIndex == index
                ? AppColors.primaryLight
                : AppColors.borderColor,
            size: currentIndex == index ? 28 : 24,
          ),
          const SizedBox(height: 4), // Add some space between icon and label
          Text(
            label,
            style: TextStyle(
              color: currentIndex == index
                  ? AppColors.primaryLight
                  : AppColors.borderColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
