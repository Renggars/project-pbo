import 'dart:math';

import 'package:aplikasi_alquran/app/modules/kiblat/controllers/kiblat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KiblatView extends GetView<KiblatController> {
  const KiblatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arah Kiblat'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
            ); // Menampilkan indikator loading saat proses
          }

          return Transform.rotate(
            angle: (controller.kiblatOffset.value -
                    controller.kiblatDirection.value) *
                (pi / 180),
            child: Icon(
              Icons.navigation,
              size: 160,
              color: Colors.teal,
            ),
          );
        }),
      ),
    );
  }
}
