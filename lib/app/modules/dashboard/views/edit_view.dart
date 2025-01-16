import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/app/data/detail_event_response.dart';
import 'package:myapp/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myapp/app/modules/dashboard/views/event_detail_view.dart';

class EditView extends GetView {
  const EditView({super.key, required this.id, required this.title});
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title:  Text('Edit $title Event'),
        centerTitle: true,
        backgroundColor: HexColor('#feeee8'),
      ),
      backgroundColor: HexColor('#feeee8'),
      body: FutureBuilder<DetailEventResponse>(
        future: controller.getDetailEvent(id: id),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                repeat: true,
                width: MediaQuery.of(context).size.width / 1,
              ),
            );
          }
          if(snapshot.hasData) {
            controller.nameController.text = snapshot.data!.name ?? '';
            controller.descriptionController.text = snapshot.data!.description ?? '';
            controller.eventDateController.text = snapshot.data!.eventDate ?? '';
            controller.locationController.text = snapshot.data!.location ?? '';
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  autofocus: true,
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Event',
                    hintText: 'Masukan Nama Event' 
                  ),
                ),
              ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Deskripsi',
                    hintText: 'Masukan Deskripsi',
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller.eventDateController, // Controller tanggal
                  readOnly: true, // Supaya cuma bisa diubah lewat picker
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tanggal Event',
                    hintText: 'Masukan Tanggal Event',
                  ),
                  onTap: () async {
                    // Date picker buat pilih tanggal
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2100), 
                    );
                    if (selectedDate != null) {
                      controller.eventDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: controller.locationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lokasi',
                    hintText: 'Masukan Lokasi Event',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
