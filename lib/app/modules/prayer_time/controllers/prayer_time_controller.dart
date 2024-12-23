import 'dart:convert';
import 'package:aplikasi_alquran/app/data/models/prayer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrayerTimeController extends GetxController {
  // State variables
  var isLoading = true.obs;
  var prayerTimes = <Prayer>[].obs;
  var errorMessage = ''.obs;

  // Fetch prayer times from API
  Future<void> fetchPrayerTimes() async {
    try {
      Uri url = Uri.parse(
          "https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/semarang/2024/12.json");
      var res = await http.get(url);

      if (res.statusCode == 200) {
        // Dekode respons sebagai daftar
        List<dynamic> data = json.decode(res.body);

        // Bersihkan data existing dan tambahkan data baru
        prayerTimes.clear();

        // Mapping data JSON ke objek Prayer
        for (var item in data) {
          prayerTimes.add(Prayer.fromJson(item));
        }

        isLoading.value = false;
      } else {
        throw Exception('Failed to load prayer times');
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPrayerTimes();
  }
}
