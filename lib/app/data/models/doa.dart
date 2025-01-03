// To parse this JSON data, do
//
//     final doa = doaFromJson(jsonString);

import 'dart:convert';

List<Doa> doaFromJson(String str) =>
    List<Doa>.from(json.decode(str).map((x) => Doa.fromJson(x)));

String doaToJson(List<Doa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doa {
  String? id;
  String? doa;
  String? ayat;
  String? latin;
  String? artinya;

  Doa({
    this.id,
    this.doa,
    this.ayat,
    this.latin,
    this.artinya,
  });

  factory Doa.fromJson(Map<String, dynamic>? json) => Doa(
        id: json?["id"],
        doa: json?["doa"],
        ayat: json?["ayat"],
        latin: json?["latin"],
        artinya: json?["artinya"],
      );

  Map<String, dynamic>? toJson() => {
        "id": id,
        "doa": doa,
        "ayat": ayat,
        "latin": latin,
        "artinya": artinya,
      };
}
