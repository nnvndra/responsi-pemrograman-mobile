
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

        // Mengatur tema dengan warna biru
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2196F3), // Biru
            primary: const Color(0xFF1976D2),   // Biru pekat
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1976D2), // Background AppBar biru
            foregroundColor: Colors.white,      // Teks dan ikon putih
            centerTitle: false,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
