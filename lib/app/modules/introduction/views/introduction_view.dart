import 'package:aplikasi_alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quran App",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              // style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 30.0,
            //   ),
            //   child: Text(
            //     "Sesibuk Itukah Kamu Hingga Sampai Belum Membaca Al-Quran",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 380,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SvgPicture.asset(
                          "assets/svgs/splash.svg",
                          fit: BoxFit
                              .cover, // Atur agar SVG menyesuaikan ukuran container
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: SizedBox(
                        width: 250,
                        height: 300,
                        child:
                            Lottie.asset("assets/lotties/animasi-quran.json"),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: -25,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[500],
                            foregroundColor:
                                const Color.fromARGB(255, 94, 36, 141),
                          ),
                          child: Text("Get Started"),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
