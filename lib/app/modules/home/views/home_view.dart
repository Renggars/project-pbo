// import 'package:aplikasi_alquran/app/data/models/surah.dart';
import 'package:aplikasi_alquran/app/constant/color.dart';
import 'package:aplikasi_alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Quran App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCHING),
            icon: const Icon(Icons.search),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assalamualaiikum",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  appLightPurple1,
                  appDarkPurple,
                ]),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -50,
                        right: 0,
                        child: Opacity(
                          opacity: 0.8,
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset(
                              "assets/images/alquran.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Terakhir dibaca",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Al-Fatihah",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Juz 1 Ayat 5",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      // body: FutureBuilder<List<Surah>>(
      //   future: controller.getAllSurah(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: Text("Tidak ada data"),
      //       );
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.length,
      //         itemBuilder: (context, index) {
      //           Surah surah = snapshot.data![index];
      //           return ListTile(
      //             onTap: () => Get.toNamed(
      //               Routes.DETAIL_SURAH,
      //               arguments: surah,
      //             ),
      //             leading: CircleAvatar(
      //               child: Text(
      //                 "${surah.number}",
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               ),
      //             ),
      //             title: Text(
      //               "${surah.name?.transliteration?.id}",
      //               style: Theme.of(context).textTheme.bodyMedium,
      //             ),
      //             subtitle: Text(
      //               "${surah.numberOfVerses} Ayat | ${surah.revelation?.id}",
      //               style: Theme.of(context).textTheme.bodySmall,
      //             ),
      //             trailing: Text(
      //               "${surah.name?.short}",
      //               style: Theme.of(context).textTheme.bodyLarge,
      //             ),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
    );
  }
}
