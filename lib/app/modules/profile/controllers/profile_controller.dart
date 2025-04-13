import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import '../../../utils/api.dart';

class ProfileController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var isLoading = false.obs;

  final authToken = GetStorage();
  final getConnect = GetConnect();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('user_name') ?? 'Admin';
    userEmail.value = prefs.getString('user_email') ?? '-';
  }

  Future<void> logout() async {
    isLoading.value = true;

    final response = await getConnect.post(
      BaseUrl.logout, // Pastikan ini adalah endpoint logout yang benar
      {},
      headers: {
        'Authorization': 'Bearer ${authToken.read('token')}',
      },
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();         // hapus data lokal SharedPreferences
      authToken.erase();           // hapus token dari GetStorage
      Get.offAllNamed('/login');   // arahkan ke halaman login
    } else {
      Get.snackbar(
        'Logout Gagal',
        response.body['message'] ?? 'Terjadi kesalahan saat logout',
        backgroundColor: Colors.red.shade700,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }
}
