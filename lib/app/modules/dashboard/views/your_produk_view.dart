import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'add_produk_view.dart';

class YourProdukView extends StatelessWidget {
  const YourProdukView({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil controller yang sudah diinisialisasi dengan Get.put
    DashboardController controller = Get.find();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddProdukView())?.then((_) {
            controller.fetchYourProduk(); // Ambil ulang data produk setelah tambah
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Data Produk'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.yourProducts.isEmpty) {
            return const Center(child: Text("Tidak ada produk"));
          }

          return ListView.builder(
            itemCount: controller.yourProducts.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              final produk = controller.yourProducts[index];
             final imageUrl = 'http://192.168.43.211:8000/images/produk/${produk.image ?? ''}';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: Text('Gambar tidak ditemukan')),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    produk.namaProduk ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    produk.deskripsi ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kategori: ${produk.kategori?.namaKategori ?? '-'}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Harga: Rp${produk.harga ?? '0'}',
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          controller.deleteProduk(id: produk.id ?? 0);
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 10),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
