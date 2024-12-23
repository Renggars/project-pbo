// To parse this JSON data, do
//
//     final prayer = prayerFromJson(jsonString);

import 'dart:convert';

List<Prayer> prayerFromJson(String str) =>
    List<Prayer>.from(json.decode(str).map((x) => Prayer.fromJson(x)));

String prayerToJson(List<Prayer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prayer {
  DateTime? tanggal;
  String? imsyak;
  String? shubuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashr;
  String? magrib;
  String? isya;

  Prayer({
    this.tanggal,
    this.imsyak,
    this.shubuh,
    this.terbit,
    this.dhuha,
    this.dzuhur,
    this.ashr,
    this.magrib,
    this.isya,
  });

  factory Prayer.fromJson(Map<String, dynamic>? json) => Prayer(
        tanggal: DateTime.parse(json?["tanggal"]),
        imsyak: json?["imsyak"],
        shubuh: json?["shubuh"],
        terbit: json?["terbit"],
        dhuha: json?["dhuha"],
        dzuhur: json?["dzuhur"],
        ashr: json?["ashr"],
        magrib: json?["magrib"],
        isya: json?["isya"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal":
            "${tanggal?.year.toString().padLeft(4, '0')}-${tanggal?.month.toString().padLeft(2, '0')}-${tanggal?.day.toString().padLeft(2, '0')}",
        "imsyak": imsyak,
        "shubuh": shubuh,
        "terbit": terbit,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "ashr": ashr,
        "magrib": magrib,
        "isya": isya,
      };
}
