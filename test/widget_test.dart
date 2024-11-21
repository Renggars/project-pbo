import 'dart:convert';

import 'package:aplikasi_alquran/app/data/models/detail_surah.dart';
import 'package:aplikasi_alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse('https://api.quran.gading.dev/surah');
  var res = await http.get(url);

  List data = (json.decode(res.body) as Map<String, dynamic>)['data'];

  // 1-114 -> index ke 113 = annas
  // print(data[113]['number']);

  // data dari api (raw data) -> Model (yang sudah disiapin)
  Surah surahAnnas = Surah.fromJson(data[113]);

  // print(surahAnnas.toJson());

  // Cara Masuk Ke Nested Model
  // print(surahAnnas.name.long);

  Uri uriAnnnas =
      Uri.parse('https://api.quran.gading.dev/surah/${surahAnnas.number}');
  var resAnnnas = await http.get(uriAnnnas);

  Map<String, dynamic> dataAnnas =
      (json.decode(resAnnnas.body) as Map<String, dynamic>)['data'];

  DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);

  print(detailSurahAnnas.verses[0].text.arab);
}
