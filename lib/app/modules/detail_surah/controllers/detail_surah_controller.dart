import 'dart:convert';

import 'package:aplikasi_alquran/app/data/db/bookmark.dart';
import 'package:get/get.dart';

import 'package:aplikasi_alquran/app/data/models/detail_surah.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  AutoScrollController scrollC = AutoScrollController();
  final player = AudioPlayer();

  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          columns: [
            "surah",
            "number_surah",
            "ayat",
            "juz",
            "via",
            "index_ayat",
            "last_read"
          ],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and number_surah = ${surah.number} and ayat = ${ayat.number?.inSurah} and juz = ${ayat.meta?.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0");
      // ignore: prefer_is_empty
      if (checkData.length != 0) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      db.insert("bookmark", {
        "surah": surah.name!.transliteration!.id!.replaceAll("'", "+"),
        "number_surah": surah.number!,
        "ayat": ayat.number?.inSurah,
        "juz": ayat.meta?.juz,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0
      });

      Get.back(); // tutup dialog
      Get.snackbar("Berhasil", "Berhasil ditambahkan ke bookmark");
    } else {
      Get.back(); // tutup dialog
      Get.snackbar("Terjadi Kesalahan", "Bookmark sudah ada");
    }
  }

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)['data'];

    return DetailSurah.fromJson(data);
  }

  void playAudio(Verse? ayat) async {
    if (ayat?.audio?.primary != null) {
      // Catching errors at load time
      try {
        // ignore: prefer_conditional_assignment
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat; // logic ketika lastVerse sudah ada
        lastVerse!.kondisiAudio = "stop";
        update();
        await player
            .stop(); //mencegah terjadi penumpukan audio yang sedang diputar
        await player.setUrl(ayat!.audio!.primary!);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: e.message.toString(),
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat memutar audio",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Audio Tidak Tersedia",
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat pause audio",
      );
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat resume audio",
      );
    }
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.message.toString(),
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Connection aborted: ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak dapat stop audio",
      );
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
