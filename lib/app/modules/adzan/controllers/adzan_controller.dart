import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:aplikasi_alquran/app/data/models/prayer.dart';

class AdzanController extends GetxController {
  var prayerTimes = RxList<Prayer>(); // Menyimpan daftar waktu adzan
  var isLoading = false.obs; // Untuk memonitor status loading

  @override
  void onInit() {
    super.onInit();
    fetchAdzanTimes(); // Mengambil data waktu adzan saat aplikasi dibuka
  }

  Future<void> fetchAdzanTimes() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/semarang/2024/12.json'));

      if (response.statusCode == 200) {
        List<Prayer> prayers = prayerFromJson(response.body);
        prayerTimes.value = prayers;
      } else {
        throw Exception('Failed to load adzan times');
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
