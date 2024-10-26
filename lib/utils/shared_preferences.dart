import 'package:shared_preferences/shared_preferences.dart';

// Function to store document ID
Future<void> storeDocumentId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('documentId', 'nta5Qswe70YAqxinQcNv');
}

// Function to retrieve document ID
Future<String?> getDocumentId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('documentId');
}
