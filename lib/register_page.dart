// lib/register_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Kunci global untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk field email, password, dan konfirmasi password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Instance dari FirebaseAuth
  final _auth = FirebaseAuth.instance;

  // State untuk loading indicator
  bool _isLoading = false;

  // Fungsi untuk menangani proses registrasi
  Future<void> _register() async {
    // Validasi form terlebih dahulu
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Membuat user baru dengan email dan password menggunakan Firebase
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Jika berhasil, tampilkan notifikasi dan kembali ke halaman login
        // agar user bisa langsung mencoba login.
        if (!mounted) return; // Pengecekan mounted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pendaftaran berhasil! Silakan login.'),
            backgroundColor: Colors.green,
          ),
        );
        // Kembali ke halaman sebelumnya (halaman login)
        Navigator.of(context).pop();

      } on FirebaseAuthException catch (e) {
        // Menangani error dari Firebase
        String message;
        if (e.code == 'weak-password') {
          message = 'Password yang dimasukkan terlalu lemah.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Email ini sudah terdaftar.';
        } else {
          message = 'Terjadi kesalahan. Silakan coba lagi.';
        }
        if (!mounted) return; // Pengecekan mounted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        // Hentikan loading indicator
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // Jangan lupa dispose controller untuk membersihkan memori
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar agar ada tombol kembali otomatis
      appBar: AppBar(
        title: const Text('Buat Akun Baru'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // Judul Halaman
                const Text(
                  'Daftarkan Akun Anda',
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
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Masukkan format email yang valid';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Input field untuk Password
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
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

                const SizedBox(height: 16),

                // Input field untuk Konfirmasi Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Konfirmasi Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi password tidak boleh kosong';
                    }
                    if (value != _passwordController.text) {
                      return 'Password tidak cocok';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 48),

                // Tombol DAFTAR
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: _register, // Memanggil fungsi _register
                        child: const Text('DAFTAR', style: TextStyle(fontSize: 16)),
                      ),

                const SizedBox(height: 24),

                // Tombol untuk kembali ke halaman login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun?'),
                    TextButton(
                      onPressed: () {
                        // Kembali ke halaman sebelumnya (halaman login)
                        Navigator.of(context).pop();
                      },
                      child: const Text('Masuk di sini'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}