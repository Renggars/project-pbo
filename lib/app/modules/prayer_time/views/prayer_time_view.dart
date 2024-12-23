import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/prayer_time_controller.dart';

class PrayerTimeView extends GetView<PrayerTimeController> {
  const PrayerTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengatur orientasi layar ke landscape saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });

    return PopScope(
      canPop: true, // Mengizinkan pengguna untuk kembali (pop)
      onPopInvokedWithResult: (didPop, result) {
        // Callback yang dipanggil setelah pop terjadi
        if (didPop) {
          // Mengembalikan orientasi layar ke portrait
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Sholat'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }

          if (controller.prayerTimes.isEmpty) {
            return const Center(child: Text("Tidak ada data"));
          }

          // Menampilkan data dalam bentuk tabel horizontal
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Tanggal")),
                  DataColumn(label: Text("Imsak")),
                  DataColumn(label: Text("Subuh")),
                  DataColumn(label: Text("Terbit")),
                  DataColumn(label: Text("Dzuhur")),
                  DataColumn(label: Text("Ashar")),
                  DataColumn(label: Text("Maghrib")),
                  DataColumn(label: Text("Isya")),
                ],
                rows: controller.prayerTimes.map((prayer) {
                  return DataRow(cells: [
                    DataCell(Text(prayer.tanggal.toString())), // Tanggal
                    DataCell(Text(prayer.imsyak.toString())), // Imsak
                    DataCell(Text(prayer.shubuh.toString())), // Subuh
                    DataCell(Text(prayer.terbit.toString())), // Terbit
                    DataCell(Text(prayer.dzuhur.toString())), // Dzuhur
                    DataCell(Text(prayer.ashr.toString())), // Ashar
                    DataCell(Text(prayer.magrib.toString())), // Maghrib
                    DataCell(Text(prayer.isya.toString())), // Isya
                  ]);
                }).toList(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
