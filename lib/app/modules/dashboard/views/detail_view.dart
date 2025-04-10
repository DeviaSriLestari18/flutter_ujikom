import 'package:flutter/material.dart';
import '../../../data/produk_response.dart';

class DetailView extends StatelessWidget {
  final Produk produk;

  const DetailView({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              produk.imageUrl ?? '',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('Gambar tidak tersedia'),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              produk.namaProduk ?? "Nama Produk",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              produk.deskripsi ?? "Deskripsi tidak tersedia",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.price_check, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "Rp${produk.harga ?? 0}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.inventory_2, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  "Stok: ${produk.stok ?? 0}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.category, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  produk.kategori?.namaKategori ?? "Kategori tidak tersedia",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
