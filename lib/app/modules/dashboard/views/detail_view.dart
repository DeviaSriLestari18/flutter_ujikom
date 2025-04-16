import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/produk_response.dart';

class DetailView extends StatelessWidget {
  final Produk produk;

  const DetailView({super.key, required this.produk});

  // Fungsi untuk membuka WhatsApp
  void _openWhatsApp(BuildContext context) async {
    final pesan = Uri.encodeComponent(
      "Halo, saya tertarik dengan produk *${produk.namaProduk}*. Apakah masih tersedia? Mohon info lebih lanjut ya.",
    );
    final waUrl = "https://wa.me/6289636985281?text=$pesan"; // Nomor WA sudah diubah

    if (await canLaunchUrl(Uri.parse(waUrl))) {
      await launchUrl(Uri.parse(waUrl), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gambar produk
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  produk.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: Text('Gambar tidak tersedia')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Card info produk
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama produk
                    Text(
                      produk.namaProduk ?? "Nama Produk",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Deskripsi
                    Text(
                      produk.deskripsi ?? "Deskripsi tidak tersedia",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Info harga, stok, kategori
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _InfoTile(
                          icon: Icons.price_check,
                          label: "Harga",
                          value: "Rp${produk.harga ?? 0}",
                          color: Colors.green,
                        ),
                        _InfoTile(
                          icon: Icons.inventory_2,
                          label: "Stok",
                          value: "${produk.stok ?? 0}",
                          color: Colors.orange,
                        ),
                        _InfoTile(
                          icon: Icons.category,
                          label: "Kategori",
                          value: produk.kategori?.namaKategori ?? "-",
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol WhatsApp
            ElevatedButton.icon(
              onPressed: () => _openWhatsApp(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.chat, color: Colors.white),
              label: const Text(
                "Hubungi via WhatsApp",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
