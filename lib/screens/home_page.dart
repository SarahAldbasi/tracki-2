import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/custom_widgets/banner_to_explore.dart';
import 'package:restaurant/custom_widgets/items_display.dart';
import 'package:restaurant/custom_widgets/my_icon_button.dart';
import 'package:restaurant/screens/auth_screens/sign_in.dart';
import 'package:restaurant/screens/truck_category_screen.dart';
import 'package:restaurant/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String category = "الكل";
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("Food-Category");

  Query get filteredItems => FirebaseFirestore.instance
      .collection("Food_Truck")
      .where("category", isEqualTo: category);

  Query get allItems => FirebaseFirestore.instance.collection("Food_Truck");
  Query get selectedTrucks => category == "الكل" ? allItems : filteredItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    headerParts(),
                    mySearchBar(),
                    const BannerToExplore(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "التصنيفات",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: selectedCategory(),
                    ),
                    const SizedBox(height: 10),
                    buildFoodTruckList(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFoodTruckList(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TruckCategoryScreen()),
                );
              },
              child: const Text(
                "عرض الكل",
                style: TextStyle(
                    color: AppColors.darkPurple, fontWeight: FontWeight.w600),
              ),
            ),
            const Text(
              "عربات الطعام",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
          stream: selectedTrucks.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> trucks = snapshot.data!.docs;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: trucks
                      .map((e) => ItemsDisplay(documentSnapshot: e))
                      .toList(),
                ),
              );
            }
            return const Text("No data available");
          },
        ),
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                (index) {
                  final categoryName = streamSnapshot.data!.docs[index]["name"];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        category = categoryName;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: category == categoryName
                            ? AppColors.primaryDark
                            : Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(right: 1, left: 15),
                      child: Text(
                        categoryName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: category == categoryName
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Text("No categories available");
      },
    );
  }

  Padding mySearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: const Icon(Icons.search),
            fillColor: AppColors.backgroundColor,
            hintText: "ابحث عن عربة طعام",
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Row headerParts() {
    return Row(
      children: [
        MyIconButton(
          icon: Icons.logout,
          pressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LogInScreen()),
            );
          },
        ),
        const Spacer(),
        const Text(
          "ما هي عربة \nالطعام التي تبحث عنها؟",
          style:
              TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
