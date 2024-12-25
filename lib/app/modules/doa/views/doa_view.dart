import 'package:aplikasi_alquran/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/doa_controller.dart';

class DoaView extends StatelessWidget {
  final DoaController controller = Get.put(DoaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa Sehari-Hari'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.doaList.length,
          itemBuilder: (context, index) {
            final doa = controller.doaList[index];

            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/list.png"),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          doa.doa ?? 'No Title',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            doa.ayat ?? '-',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 6),
                          Text(
                            doa.latin ?? '-',
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: greenPrimary),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 6),
                          Text(doa.artinya ?? ' - ',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
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
