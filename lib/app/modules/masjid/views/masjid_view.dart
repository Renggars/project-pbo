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
  List<dynamic> dataMasjid = [];

  @override
  void initState() {
    super.initState();
    loadMasjid();
  }

  Future<void> loadMasjid() async {
    final location = await _controller.getUserLocation();
    if (location != null) {
      final masjidList = await _controller.getMasjidTerdekat(
        location.latitude,
        location.longitude,
      );
      setState(() {
        userLocation = location;
        dataMasjid = masjidList;
      });

      // Debugging untuk melihat data masjid
      // print('User Location: $userLocation');
      // print('Mosques: $dataMasjid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peta Masjid Terdekat'),
        centerTitle: true,
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
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    for (var masjid in dataMasjid)
                      if (masjid['lat'] != null && masjid['lon'] != null)
                        Marker(
                          point: LatLng(
                            double.parse(masjid['lat']),
                            double.parse(masjid['lon']),
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
