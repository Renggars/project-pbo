import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_alquran/app/data/models/prayer.dart';

class AdzanController extends GetxController {
  var prayerTimes = RxList<Prayer>(); // Menyimpan daftar waktu adzan
  var isLoading = false.obs; // Untuk memonitor status loading
  final AudioPlayer _audioPlayer = AudioPlayer(); // Instance dari AudioPlayer

  // Fungsi untuk mengambil data waktu adzan dari API
  Future<void> fetchAdzanTimes() async {
    isLoading.value = true;

    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/semarang/2024/12.json'));

      if (response.statusCode == 200) {
        // Parsing JSON menjadi list Prayer
        List<Prayer> prayers = prayerFromJson(response.body);
        prayerTimes.value = prayers;

        // Cek dan mainkan adzan pada waktu yang sesuai
        _checkAndPlayAdzan(prayers);
      } else {
        throw Exception('Failed to load adzan times');
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk mengecek apakah saat ini adalah waktu sholat dan memutar adzan
  void _checkAndPlayAdzan(List<Prayer> prayers) {
    DateTime now = DateTime.now();

    // Cek apakah waktu sholat sudah tiba dan putar audio adzan
    for (Prayer prayer in prayers) {
      if (prayer.shubuh != null && _isTimeToPray(now, prayer.shubuh!)) {
        playAdzanShubuh();
      } else if (prayer.dzuhur != null && _isTimeToPray(now, prayer.dzuhur!)) {
        playAdzan();
      } else if (prayer.ashr != null && _isTimeToPray(now, prayer.ashr!)) {
        playAdzan();
      } else if (prayer.magrib != null && _isTimeToPray(now, prayer.magrib!)) {
        playAdzan();
      } else if (prayer.isya != null && _isTimeToPray(now, prayer.isya!)) {
        playAdzan();
      }
    }
  }

  // Fungsi untuk memeriksa apakah sekarang sudah waktunya sholat
  bool _isTimeToPray(DateTime currentTime, String prayerTime) {
    DateTime prayerDateTime = DateTime.parse(
        "${currentTime.year}-${currentTime.month}-${currentTime.day} $prayerTime");
    return currentTime.isAfter(prayerDateTime) &&
        currentTime.isBefore(prayerDateTime.add(Duration(minutes: 5)));
  }

  // Fungsi untuk memutar audio adzan
  void playAdzan() async {
    try {
      await _audioPlayer.setAsset(
          'assets/audio/adzan.mp3'); // Gantilah dengan path yang sesuai
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Fungsi untuk memutar audio adzan shubuh
  void playAdzanShubuh() async {
    try {
      await _audioPlayer.setAsset(
          'assets/audio/adzan_shubuh.mp3'); // Gantilah dengan path yang sesuai
      _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Fungsi untuk menghentikan audio adzan
  void stopAdzan() {
    _audioPlayer.stop();
  }
}
