import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/dashboard_controller.dart';

class AddProdukView extends StatefulWidget {
  const AddProdukView({super.key});

  @override
  State<AddProdukView> createState() => _AddProdukViewState();
}

class _AddProdukViewState extends State<AddProdukView> {
  final DashboardController controller = Get.find();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      controller.pickedImageFile = _image;
    }
  }

  @override
  void initState() {
    super.initState();
    controller.fetchKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Data Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return controller.kategoriList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    // ✅ Tambahkan animasi lottie sofa di atas
                    Center(
                      child: Lottie.asset(
                        'assets/lottie/sofa.json',
                        height: 180,
                        repeat: true,
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: controller.nameController,
                      decoration:
                          const InputDecoration(labelText: "Nama Produk"),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(labelText: "Deskripsi"),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Harga"),
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<int>(
                      value: controller.selectedCategoryId.value == 0
                          ? null
                          : controller.selectedCategoryId.value,
                      decoration: const InputDecoration(labelText: 'Kategori'),
                      items: controller.kategoriList
                          .map<DropdownMenuItem<int>>((kategoriItem) {
                        return DropdownMenuItem<int>(
                          value: kategoriItem.id,
                          child: Text(kategoriItem.namaKategori ?? '-'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedCategoryId.value = value ?? 0;
                      },
                    ),

                    const SizedBox(height: 16),

                    // ✅ Preview gambar setelah dropdown
                    if (_image != null)
                      Image.file(_image!, height: 150)
                    else
                      const Text("Tidak ada gambar"),

                    TextButton(
                      onPressed: _pickImage,
                      child: const Text("Pilih Gambar"),
                    ),

                    const SizedBox(height: 25),

                    // ✅ Tombol keren
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        controller.addProduk();
                      },
                      child: const Text("Simpan Produk"),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
