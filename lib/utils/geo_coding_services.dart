import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class GeocodingService {
  final String apiKey = 'YOUR_OPENCAGE_API_KEY'; // Replace with your API key

  Future<LatLng> getCoordinates(String query) async {
    final url = Uri.parse(
        'https://api.opencagedata.com/geocode/v1/json?q=$query&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coordinates = data['results'][0]['geometry'];
      double lat = coordinates['lat'];
      double lng = coordinates['lng'];
      return LatLng(lat, lng);
    } else {
      throw Exception('Failed to get coordinates');
    }
  }
}
