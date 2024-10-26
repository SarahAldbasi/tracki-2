import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:restaurant/utils/app_colors.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الموقع'),
        backgroundColor: AppColors.primaryDark,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              onTap: (tapPosition, point) {
                const LatLng(24.7136, 46.6753); // Coordinates of London
              },
              minZoom: 13, // Initial zoom level
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png", // No subdomains
              ),
            ],
          ),
          // Manually adding attribution at the bottom
          const Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              "© OpenStreetMap contributors",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
