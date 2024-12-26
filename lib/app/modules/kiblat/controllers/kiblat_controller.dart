import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_compass/flutter_compass.dart';

class KiblatController extends GetxController {
  var kiblatDirection = 0.0.obs; // Arah heading dari kompas
  var kiblatOffset = 0.0.obs; // Arah Ka'bah relatif terhadap utara
  var isLoading = false.obs; // Status loading untuk memantau proses

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    startCompassListener();
  }

  // Mendengarkan perubahan dari kompas
  void startCompassListener() {
    FlutterCompass.events?.listen((event) {
      if (event.heading != null) {
        kiblatDirection.value = event.heading!;
      }
    });
  }

  // Mengambil lokasi pengguna dan menghitung arah kiblat
  Future<void> getUserLocation() async {
    isLoading.value = true; // Set status loading true

    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
          "Error", "Layanan lokasi dinonaktifkan. Aktifkan untuk melanjutkan.");
      isLoading.value = false; // Set loading selesai
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Izin lokasi ditolak.");
        isLoading.value = false; // Set loading selesai
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Izin lokasi ditolak secara permanen.");
      isLoading.value = false; // Set loading selesai
      return;
    }

    // Dapatkan posisi pengguna
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );

    calculateQiblaOffset(
      position.latitude,
      position.longitude,
    );

    isLoading.value = false; // Set loading selesai
  }

  // Menghitung offset kiblat berdasarkan posisi pengguna
  void calculateQiblaOffset(double userLat, double userLon) {
    const double kaabaLat = 21.4225; // Koordinat Ka'bah
    const double kaabaLon = 39.8262;

    // Menghitung perbedaan longitude antara Ka'bah dan pengguna
    double deltaLon = (kaabaLon - userLon).toRad();

    // Rumus menghitung arah kiblat
    double y = sin(deltaLon) * cos(kaabaLat.toRad());
    double x = cos(userLat.toRad()) * sin(kaabaLat.toRad()) -
        sin(userLat.toRad()) * cos(kaabaLat.toRad()) * cos(deltaLon);

    double qiblaAngle = atan2(y, x) * (180 / pi);
    kiblatOffset.value = (qiblaAngle + 360) % 360; // Menghitung arah kiblat
  }
}

// Ekstensi untuk konversi ke radian
extension RadianConversion on double {
  double toRad() => this * pi / 180.0;
}
