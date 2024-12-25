import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
            child: SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Menyesuaikan dengan lebar layar
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => const Color(
                        0xFF557D7F), // Warna background untuk header
                  ),
                  headingTextStyle: const TextStyle(
                    color: Colors.white, // Warna teks pada header
                    fontWeight: FontWeight.bold,
                  ),
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
                  rows: controller.prayerTimes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final prayer = entry.value;
                    final isEven = index % 2 == 0;
                    final backgroundColor = isEven
                        ? const Color(0xFFF3FDFE)
                        : const Color(0xFFD2E7E8);

                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(prayer.tanggal!);

                    return DataRow(
                      color: WidgetStateProperty.resolveWith(
                          (states) => backgroundColor),
                      cells: [
                        DataCell(Text(formattedDate)),
                        DataCell(Text(prayer.imsyak.toString())),
                        DataCell(Text(prayer.shubuh.toString())),
                        DataCell(Text(prayer.terbit.toString())),
                        DataCell(Text(prayer.dzuhur.toString())),
                        DataCell(Text(prayer.ashr.toString())),
                        DataCell(Text(prayer.magrib.toString())),
                        DataCell(Text(prayer.isya.toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
