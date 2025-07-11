// main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File ini di-generate oleh FlutterFire CLI
//import 'register_page.dart';
import 'login_page.dart'; // Impor halaman login yang akan kita buat

// Fungsi utama yang akan dijalankan pertama kali saat aplikasi dibuka
void main() async {
  // Memastikan semua widget Flutter sudah siap sebelum menjalankan kode lain
  WidgetsFlutterBinding.ensureInitialized();

  // Menginisialisasi Firebase di aplikasi
  // Ini adalah langkah wajib sebelum menggunakan layanan Firebase lainnya
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menjalankan aplikasi dengan widget MyApp sebagai root
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Memberi judul pada aplikasi
      title: 'SportBike ID',
      // Mengatur tema dasar aplikasi
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Menghilangkan banner debug di pojok kanan atas
      debugShowCheckedModeBanner: false,
      // Menetapkan LoginPage sebagai halaman awal yang akan ditampilkan
      home: LoginPage(),
    );
  }
}