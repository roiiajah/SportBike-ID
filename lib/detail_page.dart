// lib/detail_page.dart

import 'package:flutter/material.dart';
import 'home_page.dart'; // Impor class Product dari home_page.dart

class DetailPage extends StatelessWidget {
  // Halaman ini menerima satu objek 'Product'
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar diambil dari nama produk
        title: Text(product.name),
      ),
      // Gunakan SingleChildScrollView agar konten bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Memastikan gambar memenuhi lebar
          children: [
            // Gambar Produk
            Image.asset(
              product.imageUrl,
              height: 300, // Atur tinggi gambar
              fit: BoxFit.cover,
            ),

            // Padding untuk semua konten teks di bawah gambar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Harga Produk
                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Garis pemisah
                  const Divider(),
                  const SizedBox(height: 16),
                  
                  // Judul Spesifikasi
                  const Text(
                    'Spesifikasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Teks Spesifikasi
                  Text(
                    product.specifications, // Ambil data spesifikasi
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5, // Jarak antar baris
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}