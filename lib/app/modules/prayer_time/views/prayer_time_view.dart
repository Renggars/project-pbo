import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/prayer_time_controller.dart';

class PrayerTimeView extends StatefulWidget {
  const PrayerTimeView({super.key});

  @override
  State<PrayerTimeView> createState() => _PrayerTimeViewState();
}

class _PrayerTimeViewState extends State<PrayerTimeView> {
  final PrayerTimeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    // Mengatur orientasi ke landscape saat widget dibuat
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // Kembalikan orientasi ke portrait saat keluar dari halaman
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Menunggu perubahan orientasi selesai sebelum halaman dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Mengembalikan orientasi layar ke portrait setelah pop
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
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith(
                    (states) =>
                        const Color(0xFF557D7F), // Header background color
                  ),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
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
                      color: MaterialStateProperty.resolveWith(
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
