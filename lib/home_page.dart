// lib/home_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart'; // Impor untuk navigasi logout
import 'detail_page.dart'; // Impor untuk navigasi ke halaman detail

// Model untuk merepresentasikan data produk dengan spesifikasi
class Product {
  final String name;
  final String price;
  final String description;
  final String imageUrl;
  final String specifications; 

  const Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.specifications, 
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Daftar produk lengkap dengan data spesifikasi
  final List<Product> productList = const [
      Product(
        name: 'Honda CBR250RR',
        price: 'Rp 80.000.000',
        description: 'Sport bike 250cc, 2 silinder.',
        imageUrl: 'assets/images/cbr250rr.png',
        specifications:
            'Tipe Mesin: 4-Langkah, DOHC 8-Katup, 2 Silinder\nKapasitas: 249.7 cc\nTenaga Maksimal: 31 kW / 13000 rpm\nTransmisi: 6-Percepatan'),
      Product(
        name: 'Yamaha R25',
        price: 'Rp 75.000.000',
        description: 'Performa tinggi dari keluarga R-Series.',
        imageUrl: 'assets/images/r25.png',
        specifications:
            'Tipe Mesin: Liquid Cooled, 4-Langkah, DOHC, 2 Silinder\nKapasitas: 249 cc\nTenaga Maksimal: 26.5 kW / 12000 rpm\nTransmisi: 6-Percepatan'),
      Product(
        name: 'Yamaha R15M',
        price: 'Rp 45.500.000',
        description: 'Konektivitas canggih Y-Connect.',
        imageUrl: 'assets/images/r15m.png',
        specifications:
            'Tipe Mesin: Liquid Cooled, 4-Langkah, SOHC, 4-Katup, VVA\nKapasitas: 155.09 cc\nTenaga Maksimal: 14.2 kW / 10000 rpm\nTransmisi: 6-Percepatan'),
      Product(
        name: 'Yamaha R6',
        price: 'Rp 350.000.000',
        description: 'Legenda sirkuit 600cc.',
        imageUrl: 'assets/images/r6.png',
        specifications:
            'Tipe Mesin: Liquid Cooled, 4-Langkah, DOHC, 16-Katup, 4 Silinder\nKapasitas: 599 cc\nTenaga Maksimal: 87.1 kW / 14500 rpm\nTransmisi: 6-Percepatan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SportBike ID'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

// Widget kartu produk yang bisa diklik untuk ke halaman detail
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Bungkus dengan InkWell agar bisa merespon saat di-tap
    return InkWell(
      onTap: () {
        // Navigasi ke DetailPage saat card di-tap, kirim data produk
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) {
                    return child;
                  }
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey[400],
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      product.name,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.price,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}