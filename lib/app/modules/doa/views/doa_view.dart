import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doa_controller.dart';

// ignore: use_key_in_widget_constructors
class DoaView extends StatelessWidget {
  final DoaController controller = Get.put(DoaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kumpulan Doa'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.doaList.length,
          itemBuilder: (context, index) {
            final doa = controller.doaList[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(doa.doa ?? 'No Title'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ayat: ${doa.ayat ?? '-'}'),
                    Text('Latin: ${doa.latin ?? '-'}'),
                    Text('Artinya: ${doa.artinya ?? '-'}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
