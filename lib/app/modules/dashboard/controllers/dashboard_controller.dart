import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

import '../../../utils/api.dart';
import '../views/index_view.dart';
// import '../views/your_produk_view.dart';
import '../../../data/produk_response.dart';
// import '../../../data/kategori_response.dart' as kategori;
import '../../../data/image_response.dart';
import '../../profile/views/profile_view.dart';

class DashboardController extends GetxController {
  // Jika tidak pakai tab navigasi, ini tidak diperlukan lagi
  var selectedIndex = 0.obs;
  void changeIndex(int index) => selectedIndex.value = index;

  // Hanya pakai IndexView
  final List<Widget> pages = [
    const IndexView(),
    const ProfileView(),
    // const YourProdukView(),
  ];

  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  var yourProducts = <Produk>[].obs;
  // var kategoriList = <kategori.Kategori>[].obs;
  var imageList = <ImageData>[].obs;

  // var selectedCategoryId = 0.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final imageUrlController = TextEditingController();

  File? pickedImageFile;

  @override
  void onInit() {
    super.onInit();
    fetchYourProduk(); // Tetap digunakan untuk tampilkan di Index
    // fetchKategori();
    fetchImageData();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageUrlController.dispose();
    super.onClose();
  }

  Future<ProdukResponse> getProduk() async {
    final response = await _getConnect.get(BaseUrl.produk, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
      return ProdukResponse.fromJson(response.body);
    }

    return ProdukResponse();
  }

  Future<void> fetchYourProduk() async {
    final result = await getProduk();
    if (result.data != null) {
      yourProducts.assignAll(result.data!);
    }
  }

  // Future<void> fetchKategori() async {
  //   final response = await _getConnect.get(BaseUrl.kategori, headers: {
  //     'Authorization': 'Bearer $token',
  //   });

  //   if (response.statusCode == 200 && response.body != null) {
  //     final kategoriResponse =
  //         kategori.KategoriResponse.fromJson(response.body);
  //     kategoriList.assignAll(kategoriResponse.data ?? []);
  //   }
  // }

  Future<void> fetchImageData() async {
    final response = await _getConnect.get(BaseUrl.image, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200 && response.body != null) {
      final imageResponse = ImageResponse.fromJson(response.body);
      imageList.assignAll(imageResponse.data);
    }
  }

  String? getImageUrlByProdukId(int idProduk) {
    try {
      final imageData = imageList.firstWhere((img) => img.idProduk == idProduk);
      return imageData.imageUrl;
    } catch (e) {
      return null;
    }
  }

  // Future<void> addProduk() async {
  //   if (pickedImageFile == null) {
  //     Get.snackbar("Error", "Silakan pilih gambar terlebih dahulu");
  //     return;
  //   }

  //   var request = http.MultipartRequest("POST", Uri.parse(BaseUrl.produk));
  //   request.headers['Authorization'] = 'Bearer $token';

  //   request.fields['nama_produk'] = nameController.text;
  //   request.fields['deskripsi'] = descriptionController.text;
  //   request.fields['harga'] = priceController.text;
  //   request.fields['id_kategori'] = selectedCategoryId.value.toString();

  //   var stream = http.ByteStream(pickedImageFile!.openRead());
  //   var length = await pickedImageFile!.length();
  //   var multipartFile = http.MultipartFile(
  //     'image',
  //     stream,
  //     length,
  //     filename: basename(pickedImageFile!.path),
  //   );

  //   request.files.add(multipartFile);

  //   var response = await request.send();

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     Get.snackbar("Sukses", "Produk berhasil ditambahkan");
  //     await fetchYourProduk();
  //     await fetchImageData();
  //     Get.back();
  //   } else {
  //     Get.snackbar("Error", "Gagal menambahkan produk");
  //   }
  // }

  // Future<void> deleteProduk({required int id}) async {
  //   final response = await _getConnect.delete(
  //     "${BaseUrl.produk}/$id",
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     Get.snackbar("Sukses", "Produk berhasil dihapus");
  //     await fetchYourProduk();
  //   } else {
  //     Get.snackbar("Error", "Gagal menghapus produk");
  //   }
  // }

  Future<Map<String, dynamic>?> getDetailProduct(int id) async {
    final response = await _getConnect.get(
      "${BaseUrl.produk}/$id",
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 && response.body != null) {
      return response.body;
    }
    return null;
  }
}
