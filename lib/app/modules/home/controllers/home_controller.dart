import 'dart:convert';

import 'package:aplikasi_alquran/app/data/db/bookmark.dart';
import 'package:get/get.dart';

import 'package:aplikasi_alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  RxBool isDarkMode = false.obs;

  DatabaseManager database = DatabaseManager.instance;

  Future<Map<String, dynamic>?> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> dataLastRead =
        await db.query("bookmark", where: "last_read = 1");
    if (dataLastRead.isEmpty) {
      // tidak ada data last read
      return null;
    } else {
      // ada data => ambil index ke 0 (karena cuma ada 1 data di dalam list)
      return dataLastRead.first;
    }
  }

  void deleteBookmark(int id) async {
    Database db = await database.db;

    await db.delete("bookmark", where: "id = $id");
    update();

    Get.back();
    Get.snackbar("Berhasil", "Telah berhasil meghapus bookmark");
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark =
        await db.query("bookmark", where: "last_read = 0");
    return allBookmark;
  }

  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse('https://api.quran.gading.dev/surah');
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)['data'];

    if (data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }
}
