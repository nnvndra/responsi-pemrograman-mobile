import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Kelas konfigurasi aplikasi yang memuat variabel lingkungan dari file .env.
class AppConfig {
  /// Memuat file .env ke dalam memori aplikasi.
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  /// Mengambil URL dasar API dari environment.
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://jsonplaceholder.typicode.com';

  /// Mengambil API Key dari environment tanpa hardcode.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}