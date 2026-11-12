import 'package:flutter/material.dart';
import 'config/app_config.dart';
import 'providers/app_provider.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviderWrapper(
      child: MaterialApp(
        title: 'Profil Mahasiswa & Catatan Kuliah',
        debugShowCheckedModeBanner: false,
        // Mengatur tema dengan warna ungu yang persis seperti gambar referensi
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF673AB7), // Ungu Material (Deep Purple)
            primary: const Color(0xFF5E35B1),  // Warna ungu AppBar yang pekat
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF5E35B1), // Memaksa warna latar AppBar ungu
            foregroundColor: Colors.white,      // Warna teks dan ikon di AppBar menjadi putih
            centerTitle: false,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}