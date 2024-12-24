import 'package:aplikasi_alquran/app/data/models/doa.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DoaController extends GetxController {
  var isLoading = true.obs;
  var doaList = <Doa>[].obs;

  @override
  void onInit() {
    fetchDoa();
    super.onInit();
  }

  Future<void> fetchDoa() async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse('https://doa-doa-api-ahmadramadhan.fly.dev/api'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        doaList.value = List<Doa>.from(jsonData.map((x) => Doa.fromJson(x)));
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
