// import 'package:aplikasi_alquran/app/data/models/surah.dart';
import 'package:aplikasi_alquran/app/constant/color.dart';
import 'package:aplikasi_alquran/app/data/models/surah.dart';
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
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.toNamed(Routes.SEARCHING),
        //     icon: const Icon(Icons.search),
        //   )
        // ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
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
              GetBuilder<HomeController>(builder: (c) {
                return FutureBuilder<Map<String, dynamic>?>(
                    future: c.getLastRead(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              greenPrimary,
                              Colors.teal[700]!,
                            ]),
                          ),
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
                                      "Loading...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      Map<String, dynamic>? lastRead = snapshot.data;

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            greenPrimary,
                            Colors.teal[700]!,
                          ]),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            onLongPress: () => {
                              if (lastRead != null)
                                {
                                  Get.defaultDialog(
                                    title: "Delete Last Read",
                                    middleText:
                                        "Yakin ingin menghapus last read?",
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: greenPrimary,
                                            foregroundColor: Colors.white),
                                        child: Text(
                                          "CANCEL",
                                          style: TextStyle(
                                              color: Colors
                                                  .white), // Warna teks putih
                                        ), // Background hijau
                                      ),
                                      SizedBox(width: 5),
                                      ElevatedButton(
                                        onPressed: () {
                                          c.deleteBookmark(lastRead["id"]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: greenPrimary,
                                            foregroundColor: Colors.white),
                                        child: Text(
                                          "DELETE",
                                          style: TextStyle(
                                              color: Colors
                                                  .white), // Warna teks putih
                                        ), // Background hijau
                                      ),
                                    ],
                                  )
                                }
                            },
                            onTap: () => {
                              if (lastRead != null)
                                {
                                  // bisa di arahkan ke page last read
                                  Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name": lastRead["surah"]
                                          .toString()
                                          .replaceAll("+", "'"),
                                      "number": lastRead["number_surah"],
                                      "bookmark": lastRead,
                                    },
                                  )
                                }
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -50,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.9,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        lastRead == null
                                            ? ""
                                            : lastRead["surah"]
                                                .toString()
                                                .replaceAll("+", "'"),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        lastRead == null
                                            ? "Belum ada data"
                                            : "Juz ${lastRead["juz"]} | Ayat ${lastRead["ayat"]}",
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
                      );
                    });
              }),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.PRAYER_TIME);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Sholat",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.ADZAN);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Adzan",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.KIBLAT);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.explore,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Kiblat",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.MASJID);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Masjid",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DOA);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: greenPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.menu_book,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Doa",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.teal[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TabBar(
                indicatorColor: greenPrimary,
                labelColor: greenPrimary,
                tabs: [
                  Tab(
                    text: "Surah",
                  ),
                  Tab(
                    text: "Bookmark",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // SURAH
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("Tidak ada data"),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(
                                  Routes.DETAIL_SURAH,
                                  arguments: {
                                    "name": surah.name!.transliteration!.id,
                                    "number": surah.number!,
                                  },
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/list.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${surah.number}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${surah.name?.transliteration?.id}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                subtitle: Text(
                                  "${surah.numberOfVerses} Ayat | ${surah.revelation?.id}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: Text(
                                  "${surah.name?.short}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    // Bookmark
                    GetBuilder<HomeController>(builder: (c) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: c.getBookmark(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // ignore: prefer_is_empty
                          if (snapshot.data!.length == 0) {
                            return Center(
                              child: Text("Belum ada bookmark"),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> dataBookmark =
                                  snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name": dataBookmark["surah"]
                                          .toString()
                                          .replaceAll("+", "'"),
                                      "number": dataBookmark["number_surah"],
                                      "bookmark": dataBookmark,
                                    },
                                  );
                                },
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/list.png",
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  dataBookmark["surah"]
                                      .toString()
                                      .replaceAll("+", "'"),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                subtitle: Text(
                                  "Ayat ${dataBookmark["ayat"]}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    c.deleteBookmark(dataBookmark["id"]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
