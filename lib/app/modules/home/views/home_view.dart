import 'package:aplikasi_alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                  onTap: () => Get.toNamed("/surah", arguments: surah),
                  leading: CircleAvatar(
                    child: Text("${surah.number}"),
                  ),
                  title: Text(surah.name.transliteration.id),
                  subtitle: Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation.id}"),
                  trailing: Text(surah.name.short),
                );
              },
            );
          }
        },
      ),
    );
  }
}