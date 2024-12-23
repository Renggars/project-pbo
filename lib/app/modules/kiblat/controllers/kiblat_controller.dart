import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';

class KiblatController extends GetxController {
  var kiblatDirection = 0.0.obs; // Arah kompas
  var userLocation = Rxn<Position>(); // Lokasi pengguna (bisa null)
  var qiblaDirection = 0.0.obs; // Arah kiblat

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    startCompassListener();
  }

  void startCompassListener() {
    FlutterCompass.events!.listen((event) {
      if (event.heading != null) {
        kiblatDirection.value = event.heading!;
      }
    });
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          "Error", "Layanan lokasi dinonaktifkan. Aktifkan untuk melanjutkan.");
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Izin lokasi ditolak.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Izin lokasi ditolak secara permanen.");
      return;
    }

    // Dapatkan lokasi pengguna
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    userLocation.value = position;
    calculateQiblaDirection(
      position.latitude,
      position.longitude,
    );
  }

  void calculateQiblaDirection(double userLat, double userLon) {
    const double kaabaLat = 21.4225;
    const double kaabaLon = 39.8262;

    double deltaLon = (kaabaLon - userLon).toRad();

    double y = sin(deltaLon) * cos(kaabaLat.toRad());
    double x = cos(userLat.toRad()) * sin(kaabaLat.toRad()) -
        sin(userLat.toRad()) * cos(kaabaLat.toRad()) * cos(deltaLon);

    double qiblaAngle = atan2(y, x) * (180 / pi);
    qiblaDirection.value = (qiblaAngle + 360) % 360;
  }
}

// Ekstensi untuk konversi ke radian
extension RadianConversion on double {
  double toRad() => this * pi / 180.0;
}
