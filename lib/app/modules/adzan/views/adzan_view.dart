import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adzan_controller.dart';

class AdzanView extends StatelessWidget {
  const AdzanView({super.key});

  @override
  Widget build(BuildContext context) {
    final AdzanController controller = Get.put(AdzanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Waktu Adzan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Tombol untuk memuat data waktu adzan
            ElevatedButton(
              onPressed: () {
                controller.fetchAdzanTimes(); // Memuat data waktu adzan
              },
              child: Text('Load Waktu Adzan'),
            ),
            SizedBox(height: 20),

            // Menampilkan status loading atau data waktu adzan
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                if (controller.prayerTimes.isEmpty) {
                  return Text('Tidak ada data.');
                } else {
                  // Menampilkan waktu adzan hari ini saja
                  var todayPrayers = controller.prayerTimes
                      .where((prayer) =>
                          prayer.tanggal?.day == DateTime.now().day &&
                          prayer.tanggal?.month == DateTime.now().month &&
                          prayer.tanggal?.year == DateTime.now().year)
                      .toList();

                  return Column(
                    children: todayPrayers.map((prayer) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal: ${prayer.tanggal?.toLocal()}'),
                          Text('Imsyak: ${prayer.imsyak}'),
                          Text('Shubuh: ${prayer.shubuh}'),
                          Text('Dzuhur: ${prayer.dzuhur}'),
                          Text('Ashr: ${prayer.ashr}'),
                          Text('Magrib: ${prayer.magrib}'),
                          Text('Isya: ${prayer.isya}'),
                          SizedBox(height: 10),
                          // Tombol untuk memutar adzan biasa
                          ElevatedButton(
                            onPressed: () {
                              controller.playAdzan(); // Memutar adzan biasa
                            },
                            child: Text('Putar Adzan Biasa'),
                          ),
                          SizedBox(height: 10),
                          // Tombol untuk memutar adzan shubuh
                          ElevatedButton(
                            onPressed: () {
                              controller.playAdzanShubuh();
                            },
                            child: Text('Putar Adzan Shubuh'),
                          ),
                          SizedBox(height: 10),
                          // Tombol untuk menghentikan adzan
                          ElevatedButton(
                            onPressed: () {
                              controller
                                  .stopAdzan(); // Menstop adzan yang sedang diputar
                            },
                            child: Text('Stop Adzan'),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
