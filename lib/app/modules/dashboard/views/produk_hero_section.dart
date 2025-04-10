import 'package:flutter/material.dart';

class ProdukHeroSection extends StatelessWidget {
  const ProdukHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.asset(
            'assets/images/bg_1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // Overlay gelap
        Container(
          height: 250,
          width: double.infinity,
          color: Colors.black.withOpacity(0.4),
        ),
        // Konten teks
        SizedBox(
          height: 250,
          child: Stack(
            children: [
              // "DEVIA INTERIOR" pojok kiri atas
              const Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'DEVIA INTERIOR',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              // Judul dan breadcrumb di tengah
              // Ubah bagian ini di dalam Center
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Temukan Sentuhan Elegan',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Koleksi furnitur terbaik untuk kenyamanan dan gaya hidup Anda',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
