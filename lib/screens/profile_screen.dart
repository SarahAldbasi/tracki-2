import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/screens/auth_screens/sign_in.dart';
import 'package:restaurant/screens/menu_page.dart';
import 'package:restaurant/utils/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Firestore, Auth, and Storage instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Variables for user data
  bool isLoading = true;
  String? profileImageUrl;

  // Method to pick and upload the image
  Future<void> _pickAndUploadImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        String userId = _auth.currentUser!.uid;
        Reference storageRef =
            _storage.ref().child('profile_images/$userId.jpg');

        // Upload image to Firebase Storage
        await storageRef.putFile(imageFile);

        // Get download URL and update Firestore document
        String downloadUrl = await storageRef.getDownloadURL();
        await _firestore.collection('users').doc(userId).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          profileImageUrl = downloadUrl;
          isLoading = false;
        });

        print("Image uploaded successfully: $downloadUrl");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Fetch user data
  Future<void> _fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot document =
            await _firestore.collection('users').doc(currentUser.uid).get();

        if (document.exists) {
          setState(() {
            nameController.text = document['userName'] ?? '';
            emailController.text = document['email'] ?? '';
            profileImageUrl = document['profileImageUrl'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print('No such document found');
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Logout method
  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch user data on screen load
    _fetchUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const MenuPage();
                },
              ));
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.textColor,
            ),
          ),
        ],
        title: const Text('الملف الشخصي',
            style: TextStyle(color: AppColors.textColor)),
        centerTitle: true,
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.backgroundColor,
                            backgroundImage: profileImageUrl != null
                                ? NetworkImage(
                                    profileImageUrl!) // Load network image if available
                                : const AssetImage(
                                        'lib/assets/Portrait_Placeholder.png')
                                    as ImageProvider, // Load asset if network image is not available
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: _pickAndUploadImage,
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryDark,
                                child: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildCustomTextField(
                        controller: nameController,
                        labelText: 'الاسم',
                        hintText: 'أدخل الاسم',
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الاسم';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildCustomTextField(
                        controller: emailController,
                        labelText: 'البريد الالكتروني',
                        hintText: 'أدخل البريد الالكتروني',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال البريد الالكتروني';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9._]+@[a-zA-Z]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return 'الرجاء إدخال بريد الكتروني صالح';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildCustomTextField(
                        controller: passwordController,
                        labelText: 'كلمه المرور',
                        hintText: 'أدخل كلمه المرور',
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمه المرور';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.85,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('تم تعديل الملف الشخصي بنجاح'),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('تعديل الملف الشخصي',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Logout button
                      GestureDetector(
                        onTap: _logout,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'تسجيل خروج',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Custom TextField widget
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(icon, color: AppColors.primaryDark),
        filled: true,
        fillColor: AppColors.backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.lightPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primaryDark),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }
}
