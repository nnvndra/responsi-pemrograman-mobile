/// Kelas utilitas untuk validasi dan sanitasi input pengguna.
class Validators {
  /// Memvalidasi judul catatan (3 - 50 karakter).
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Judul catatan wajib diisi';
    }
    final trimmed = value.trim();
    if (trimmed.length < 3) {
      return 'Judul minimal 3 karakter';
    }
    if (trimmed.length > 50) {
      return 'Judul maksimal 50 karakter';
    }
    return null;
  }

  /// Memvalidasi isi catatan (10 - 1000 karakter).
  static String? validateContent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Isi catatan wajib diisi';
    }
    final trimmed = value.trim();
    if (trimmed.length < 10) {
      return 'Isi catatan minimal 10 karakter';
    }
    if (trimmed.length > 1000) {
      return 'Isi catatan maksimal 1000 karakter';
    }
    return null;
  }

  /// Membersihkan karakter berbahaya (<, >, ", ') untuk mencegah injeksi.
  static String sanitize(String input) {
    return input
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('"', '')
        .replaceAll("'", '')
        .trim();
  }
}