import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Tambahkan package intl
import '../controllers/adzan_controller.dart';

class AdzanView extends StatelessWidget {
  const AdzanView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdzanController controller = Get.put(AdzanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waktu Adzan Hari Ini'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.prayerTimes.isEmpty) {
            return const Center(child: Text('Tidak ada data waktu adzan.'));
          } else {
            var todayPrayers = controller.prayerTimes.where((prayer) {
              final today = DateTime.now();
              return prayer.tanggal?.day == today.day &&
                  prayer.tanggal?.month == today.month &&
                  prayer.tanggal?.year == today.year;
            }).toList();

            if (todayPrayers.isEmpty) {
              return const Center(
                  child:
                      Text('Data waktu adzan untuk hari ini tidak tersedia.'));
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: todayPrayers.map((prayer) {
                  final DateFormat dateFormat = DateFormat('dd MMM yyyy');
                  String formattedDate = dateFormat.format(prayer.tanggal!);

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tanggal: $formattedDate',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildPrayerTimeRow('Shubuh', prayer.shubuh),
                          _buildPrayerTimeRow('Dzuhur', prayer.dzuhur),
                          _buildPrayerTimeRow('Ashr', prayer.ashr),
                          _buildPrayerTimeRow('Magrib', prayer.magrib),
                          _buildPrayerTimeRow('Isya', prayer.isya),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }),
      ),
    );
  }

  // Widget untuk menampilkan baris waktu adzan
  Widget _buildPrayerTimeRow(String prayerName, String? prayerTime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$prayerName ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          prayerTime ?? '-',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
