import 'package:get/get.dart';

import '../modules/adzan/bindings/adzan_binding.dart';
import '../modules/adzan/views/adzan_view.dart';
import '../modules/detail_surah/bindings/detail_surah_binding.dart';
import '../modules/detail_surah/views/detail_surah_view.dart';
import '../modules/doa/bindings/doa_binding.dart';
import '../modules/doa/views/doa_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/kiblat/bindings/kiblat_binding.dart';
import '../modules/kiblat/views/kiblat_view.dart';
import '../modules/last_read/bindings/last_read_binding.dart';
import '../modules/last_read/views/last_read_view.dart';
import '../modules/masjid/bindings/masjid_binding.dart';
import '../modules/masjid/views/masjid_view.dart';
import '../modules/prayer_time/bindings/prayer_time_binding.dart';
import '../modules/prayer_time/views/prayer_time_view.dart';
import '../modules/searching/bindings/searching_binding.dart';
import '../modules/searching/views/searching_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHING,
      page: () => const SearchingView(),
      binding: SearchingBinding(),
    ),
    GetPage(
      name: _Paths.LAST_READ,
      page: () => const LastReadView(),
      binding: LastReadBinding(),
    ),
    GetPage(
      name: _Paths.PRAYER_TIME,
      page: () => const PrayerTimeView(),
      binding: PrayerTimeBinding(),
    ),
    GetPage(
      name: _Paths.KIBLAT,
      page: () => const KiblatView(),
      binding: KiblatBinding(),
    ),
    GetPage(
      name: _Paths.DOA,
      page: () => DoaView(),
      binding: DoaBinding(),
    ),
    GetPage(
      name: _Paths.MASJID,
      page: () => MasjidView(),
      binding: MasjidBinding(),
    ),
    GetPage(
      name: _Paths.ADZAN,
      page: () => const AdzanView(),
      binding: AdzanBinding(),
    ),
  ];
}
