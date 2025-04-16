import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8), 
      body: Obx(
        () => SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Profil Saya',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D1B2A), // Navy
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFFB0BEC5), // Soft Grey avatar
                    child: Icon(Icons.person, size: 65, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    controller.userName.value, // Admin di sini
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    controller.userEmail.value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 36),
                  ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.logout();
                          },
                    icon: const Icon(Icons.logout),
                    label: controller.isLoading.value
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC3F7), // Blue soft
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 4,
                      shadowColor: Colors.blueAccent.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
