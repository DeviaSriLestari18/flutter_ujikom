import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../utils/api.dart';
import '../views/index_view.dart';
import '../views/your_produk_view.dart';
import '../../../data/produk_response.dart';
import '../../../data/image_response.dart';
import '../../../data/kategori_response.dart' as kategori;

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  void changeIndex(int index) => selectedIndex.value = index;

  final List<Widget> pages = [IndexView(), YourProdukView()];
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  var yourProducts = <Produk>[].obs;
  var kategoriList = <kategori.Kategori>[].obs;
  var selectedCategoryId = 0.obs;
  var imageProdukList = <ImageProduk>[].obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final imageUrlController = TextEditingController();
  File? pickedImageFile;

  Future<void> fetchYourProduk() async {
    final result = await getProduk();
    if (result.data != null) yourProducts.assignAll(result.data!);
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

  Future<void> fetchKategori() async {
    final response = await _getConnect.get(BaseUrl.kategori, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200 && response.body != null) {
      final kategoriResponse =
          kategori.KategoriResponse.fromJson(response.body);
      kategoriList.assignAll(kategoriResponse.data ?? []);
    }
  }

  Future<void> addProduk() async {
    if (pickedImageFile == null) {
      Get.snackbar("Error", "Silakan pilih gambar terlebih dahulu");
      return;
    }

    var request = http.MultipartRequest("POST", Uri.parse(BaseUrl.produk));
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['nama_produk'] = nameController.text;
    request.fields['deskripsi'] = descriptionController.text;
    request.fields['harga'] = priceController.text;
    request.fields['id_kategori'] = selectedCategoryId.value.toString();

    var stream = http.ByteStream(pickedImageFile!.openRead());
    var length = await pickedImageFile!.length();
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(pickedImageFile!.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar("Sukses", "Produk berhasil ditambahkan");
      await fetchYourProduk();
      Get.back();
    } else {
      Get.snackbar("Error", "Gagal menambahkan produk");
    }
  }

  Future<void> deleteProduk({required int id}) async {
    final response = await _getConnect.delete(
      "${BaseUrl.produk}/$id",
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Get.snackbar("Sukses", "Produk berhasil dihapus");
      await fetchYourProduk();
    } else {
      Get.snackbar("Error", "Gagal menghapus produk");
    }
  }

  Future<void> fetchImageProduk() async {
    final response =
        await http.get(Uri.parse('http://192.168.43.211:8000/api/image'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      imageProdukList.value = (jsonData['data'] as List)
          .map((item) => ImageProduk.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal mengambil data gambar');
    }
  }

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

  @override
  void onInit() {
    super.onInit();
    fetchYourProduk();
    fetchImageProduk();
    fetchKategori();
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
}
