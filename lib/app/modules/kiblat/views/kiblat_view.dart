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
      body: Obx(() {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: (controller.qiblaDirection.value * (pi / 180)),
                child: Icon(
                  Icons.navigation,
                  size: 200,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Arah Kiblat: ${controller.qiblaDirection.value.toStringAsFixed(2)}°',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.getUserLocation,
                child: const Text('Perbarui Lokasi'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
