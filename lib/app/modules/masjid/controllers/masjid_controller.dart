import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

class MasjidController {
  LatLng? userLocation;
  List<dynamic> mosques = [];

  // Mendapatkan lokasi pengguna dengan LocationSettings
  Future<LatLng?> getUserLocation() async {
    try {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0, // Update setiap pergerakan kecil
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      userLocation = LatLng(position.latitude, position.longitude);
      return userLocation;
    } catch (e) {
      print('Error mendapatkan lokasi: $e');
      return null;
    }
  }

  // Mengambil data masjid terdekat menggunakan Nominatim API
  Future<List<dynamic>> getNearbyMosques(double lat, double lon) async {
    try {
      final url = 'https://nominatim.openstreetmap.org/search';
      final response = await Dio().get(url, queryParameters: {
        'q': 'mosque',
        'format': 'json',
        'limit': 10,
        'lat': lat,
        'lon': lon,
        'radius': 2000, // Radius pencarian dalam meter
      });

      if (response.statusCode == 200) {
        mosques = response.data;
        return mosques;
      } else {
        return [];
      }
    } catch (e) {
      print('Error mengambil data masjid: $e');
      return [];
    }
  }
}
