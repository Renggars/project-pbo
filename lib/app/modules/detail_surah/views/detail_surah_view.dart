import 'package:aplikasi_alquran/app/constant/color.dart';
import 'package:aplikasi_alquran/app/data/models/detail_surah.dart' as detail;
import 'package:aplikasi_alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../controllers/detail_surah_controller.dart';

// ignore: must_be_immutable
class DetailSurahView extends GetView<DetailSurahController> {
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;

  DetailSurahView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surah ${Get.arguments["name"]}"),
      ),
      body: FutureBuilder<detail.DetailSurah>(
          future: controller.getDetailSurah(Get.arguments["number"].toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text("Tidak ada data"),
              );
            }

            if (Get.arguments["bookmark"] != null) {
              bookmark = Get.arguments["bookmark"];
              if (bookmark!["index_ayat"] > 0) {
                controller.scrollC.scrollToIndex(
                  bookmark!["index_ayat"] + 1,
                  preferPosition: AutoScrollPosition.begin,
                );
              }
            }
            detail.DetailSurah surah = snapshot.data!;

            List<Widget> allAyat =
                List.generate(snapshot.data?.verses?.length ?? 0, (index) {
              detail.Verse ayat = snapshot.data!.verses![index];
              return AutoScrollTag(
                key: ValueKey(index + 1),
                index: index + 1,
                controller: controller.scrollC,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ),
                            GetBuilder<DetailSurahController>(
                              builder: (c) => Row(children: [
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                        title: "Bookmark",
                                        middleText: "Pilih jenis Bookmark",
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              await c.addBookmark(
                                                true,
                                                snapshot.data!,
                                                ayat,
                                                index,
                                              );
                                              homeC.update();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: greenPrimary,
                                                foregroundColor: Colors.white),
                                            child: Text("LAST READ"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              c.addBookmark(
                                                false,
                                                snapshot.data!,
                                                ayat,
                                                index,
                                              );
                                              homeC.update();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: greenPrimary,
                                                foregroundColor: Colors.white),
                                            child: Text("BOOKMARK"),
                                          ),
                                        ]);
                                  },
                                  icon:
                                      Icon(Icons.collections_bookmark_outlined),
                                ),
                                (ayat.kondisiAudio == "stop")
                                    ? IconButton(
                                        onPressed: () {
                                          c.playAudio(ayat);
                                        },
                                        icon: Icon(Icons.play_arrow),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (ayat.kondisiAudio == "playing")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.pauseAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.pause),
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    c.resumeAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.play_arrow),
                                                ),
                                          IconButton(
                                            onPressed: () {
                                              c.stopAudio(ayat);
                                            },
                                            icon: Icon(Icons.stop),
                                          )
                                        ],
                                      )
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "${ayat.text?.arab}",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${ayat.text?.transliteration?.en}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: greenPrimary),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${ayat.translation?.id}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            });

            return ListView(
              controller: controller.scrollC,
              padding: EdgeInsets.all(20),
              children: [
                AutoScrollTag(
                  key: ValueKey(0),
                  index: 0,
                  controller: controller.scrollC,
                  child: GestureDetector(
                    onTap: () => Get.defaultDialog(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      title: "Tafsir ${surah.name?.transliteration?.id}",
                      content: Text("${surah.tafsir?.id}"),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [
                          greenPrimary,
                          Colors.teal[700]!,
                        ]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Text(
                              "${surah.name?.transliteration?.id?.toUpperCase()}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: appWhite,
                              ),
                            ),
                            Text(
                              "( ${surah.name?.translation?.id?.toUpperCase()} )",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: appWhite,
                              ),
                            ),
                            Text(
                              "${surah.numberOfVerses.toString()} Ayat | ${surah.revelation?.id}",
                              style: TextStyle(
                                fontSize: 16,
                                color: appWhite,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ...allAyat,
              ],
            );
          }),
    );
  }
}
