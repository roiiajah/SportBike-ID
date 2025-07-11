// login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

// Membuat widget StatefulWidget karena perlu mengelola state
// seperti input dari user dan proses loading saat login.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kunci global untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk mengambil teks dari field E-mail dan Password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instance dari FirebaseAuth untuk berinteraksi dengan layanan autentikasi Firebase
  final _auth = FirebaseAuth.instance;

  // Variabel untuk mengontrol status loading
  bool _isLoading = false;

  // Fungsi untuk menangani proses login
  Future<void> _login() async {
    // Memeriksa apakah semua input pada form sudah valid
    if (_formKey.currentState!.validate()) {
      // Mengubah state menjadi loading
      setState(() {
        _isLoading = true;
      });

      try {
        // Melakukan proses login dengan email dan password menggunakan Firebase Auth
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (!mounted) return;
        // Jika login berhasil, navigasi ke halaman utama (home screen)
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );

      } on FirebaseAuthException catch (e) {
        // Menangani berbagai jenis error dari Firebase Auth
        String message;
        if (e.code == 'user-not-found') {
          message = 'User dengan email ini tidak ditemukan.';
        } else if (e.code == 'wrong-password') {
          message = 'Password yang dimasukkan salah.';
        } else {
          message = 'Terjadi kesalahan. Coba lagi.';
        }
        // Menampilkan pesan error kepada user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        // Mengembalikan state loading menjadi false setelah proses selesai
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Membersihkan controller saat widget tidak lagi digunakan untuk menghindari memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold adalah kerangka dasar untuk sebuah halaman di Material Design
    return Scaffold(
      body: SafeArea(
        // SafeArea memastikan konten tidak terhalang oleh notch atau status bar
        child: SingleChildScrollView(
          // Memungkinkan layar untuk di-scroll jika kontennya melebihi ukuran layar
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              // Menyusun widget secara vertikal
              mainAxisAlignment: MainAxisAlignment.center, // Pusatkan konten secara vertikal
              crossAxisAlignment: CrossAxisAlignment.stretch, // Lebarkan widget sesuai lebar layar
              children: [
                // Memberi jarak dari atas layar
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/logo_launcher.png',
                  height: 150, 
                  width: 150,  
                ),

                const SizedBox(height: 48),

                // Teks "SportBike ID"
                const Text(
                  'SportBike ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 48),

                // Input field untuk E-mail
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // Validasi input email
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@')) {
                      return 'Masukkan format email yang valid';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Input field untuk Password
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true, // Menyembunyikan teks password
                  // Validasi input password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal harus 6 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 48),

                // Tombol MASUK
                // Jika sedang loading, tampilkan CircularProgressIndicator, jika tidak, tampilkan tombol.
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _login, // Memanggil fungsi _login saat ditekan
                        child: const Text(
                          'MASUK',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                const SizedBox(height: 24),

                // Teks untuk navigasi ke halaman pendaftaran (Sign Up)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //const Text('Belum punya akun?'),
                    // Membuat teks "Daftar Sekarang" bisa di-klik
                    //TextButton(
                      //onPressed: () {

                     // },
                      //child: const Text('Daftar Sekarang'),
                    //),
                  ],
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}