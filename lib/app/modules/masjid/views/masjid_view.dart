import 'package:aplikasi_alquran/app/modules/masjid/controllers/masjid_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MasjidView extends StatefulWidget {
  @override
  _MasjidViewState createState() => _MasjidViewState();
}

class _MasjidViewState extends State<MasjidView> {
  final MasjidController _controller = MasjidController();
  LatLng? userLocation;
  List<dynamic> mosques = [];

  @override
  void initState() {
    super.initState();
    loadMosques();
  }

  Future<void> loadMosques() async {
    final location = await _controller.getUserLocation();
    if (location != null) {
      final mosqueList = await _controller.getNearbyMosques(
        location.latitude,
        location.longitude,
      );
      setState(() {
        userLocation = location;
        mosques = mosqueList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta Masjid Terdekat'),
      ),
      body: userLocation == null
          ? Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: userLocation!,
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    // Marker untuk lokasi pengguna
                    Marker(
                      point: userLocation!,
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                    // Marker untuk masjid terdekat
                    for (var mosque in mosques)
                      Marker(
                        point: LatLng(
                          double.parse(mosque['lat']),
                          double.parse(mosque['lon']),
                        ),
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}
