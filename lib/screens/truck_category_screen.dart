import 'package:flutter/material.dart';
import 'package:restaurant/utils/app_colors.dart';

class TruckCategoryScreen extends StatelessWidget {
  const TruckCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Temporary sample truck data (You can replace this with real data)
    final List<Map<String, String>> trucks = [
      {
        "name": "UTruck",
        "rating": "4.92",
        "reviews": "97",
        "time": "5:00pm - 2:00am"
      },
      {
        "name": "Takki",
        "rating": "4.3",
        "reviews": "193",
        "time": "6:00am - 1:30pm"
      },
      {
        "name": "Truck | عربية",
        "rating": "4.5",
        "reviews": "100",
        "time": "11:30am - 12:00pm"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("عربات الطعام"),
        backgroundColor: AppColors.primaryDark, // Set the app bar color
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: trucks.length,
        itemBuilder: (context, index) {
          final truck = trucks[index];

          return Card(
            color: AppColors
                .lightestPurple, // Apply background color from the theme
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
                  BorderSide(color: AppColors.borderColor), // Set border color
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the start
                children: [
                  // Image Container (You can replace this with the actual image)
                  Container(
                    width: double.infinity, // Fill the card width
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          AppColors.lightPurple, // Color for image background
                    ),
                    child: const Icon(Icons.image,
                        size: 40, color: AppColors.textColor),
                  ),
                  const SizedBox(height: 10),

                  // Truck details (name, rating, and hours)
                  Text(
                    truck["name"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor, // Apply text color from theme
                      overflow: TextOverflow.ellipsis, // Handle long names
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(
                        '${truck["rating"]} / 5 (${truck["reviews"]} reviews)',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Open Hours: ${truck["time"]}',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textColor),
                  ),
                  const Spacer(), // Push the favorite button to the bottom

                  // Favorite Icon (aligned at the bottom)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: AppColors.primaryLight),
                      onPressed: () {
                        // Add to favorites functionality
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns, similar to Instagram
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 0.6, // Adjust the aspect ratio for a taller card
        ),
      ),
    );
  }
}
