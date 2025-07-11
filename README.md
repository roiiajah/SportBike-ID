<p align="center">
  <img src="assets/images/logo_launcher.png" alt="SportBike ID Logo" width="150"/>
</p>

<h1 align="center">SportBike ID</h1>

<p align="center">
  Aplikasi mobile katalog motor sport yang dibangun dengan Flutter dan terintegrasi dengan Firebase.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Firebase-Auth-orange?logo=firebase" alt="Firebase Auth">
  <img src="https://img.shields.io/badge/Platform-Android-green?logo=android" alt="Platform">
  <img src="https://img.shields.io/badge/License-MIT-purple" alt="License">
</p>

---

## 📸 Tampilan Aplikasi (Screenshots)

Berikut adalah beberapa tampilan dari aplikasi SportBike ID.

| Halaman Login | Halaman Utama | Halaman Detail |
| :-----------: | :-----------: | :--------------: |
| ![Login_Page](https://github.com/user-attachments/assets/c9d52379-b9f6-4c71-b2a2-f896ce3502f4)
| ![Home_Page](https://github.com/user-attachments/assets/807e407f-d564-421c-a549-595676d1ffa8)
| ![Detail_Page](https://github.com/user-attachments/assets/21ac39d5-4452-4c24-8f0d-efb1cf4d4eb9)
|

---

## ✨ Fitur (Features)

-   🔐 **Autentikasi Pengguna:** Sistem login dan registrasi menggunakan Firebase Authentication (Email & Password).
-   🚪 **Sesi Login:** Pengguna tetap login hingga mereka keluar secara manual.
-   🏍️ **Katalog Produk:** Menampilkan daftar motor sport dalam tampilan grid yang rapi.
-   📄 **Halaman Detail:** Halaman detail untuk setiap motor, menampilkan gambar, harga, dan spesifikasi lengkap.
-   🎨 **Ikon Aplikasi Kustom:** Ikon aplikasi yang unik saat diinstal di perangkat.
-   🚀 **Navigasi yang Mulus:** Alur navigasi yang jelas dari login, ke halaman utama, lalu ke detail produk.

---

## 🛠️ Teknologi yang Digunakan (Tech Stack)

-   **Framework:** Flutter
-   **Backend & Autentikasi:** Firebase Authentication
-   **Package Utama:**
    -   `firebase_core`
    -   `firebase_auth`
    -   `flutter_launcher_icons` (dev dependency)

---

## 🚀 Memulai (Getting Started)

Ikuti langkah-langkah berikut untuk menjalankan proyek ini di mesin lokal Anda.

### Prasyarat (Prerequisites)

-   Pastikan Anda sudah menginstal [Flutter SDK](https://flutter.dev/docs/get-started/install) di komputer Anda.
-   Sebuah IDE seperti [VS Code](https://code.visualstudio.com/) atau [Android Studio](https://developer.android.com/studio).

### Instalasi (Installation)

1.  **Clone repositori ini:**
    ```sh
    git clone [https://github.com/](https://github.com/)[NAMA_USER_ANDA]/sportbike_id.git
    ```

2.  **Pindah ke direktori proyek:**
    ```sh
    cd sportbike_id
    ```

3.  **Setup Proyek Firebase Anda:**
    -   Buka [Firebase Console](https://console.firebase.google.com/) dan buat proyek baru.
    -   Aktifkan **Authentication** dengan metode **Email/Password**.
    -   Ikuti petunjuk untuk menambahkan aplikasi Android ke proyek Firebase Anda. Anda perlu **mendapatkan file `google-services.json` Anda sendiri**.
    -   Letakkan file `google-services.json` yang baru Anda unduh di dalam direktori `android/app/`.
    -   Jalankan `flutterfire configure` untuk menghasilkan file `firebase_options.dart`.

4.  **Install semua dependency:**
    ```sh
    flutter pub get
    ```

5.  **Jalankan aplikasi:**
    ```sh
    flutter run
    ```

---
