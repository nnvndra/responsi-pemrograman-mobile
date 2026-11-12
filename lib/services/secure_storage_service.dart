import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Layanan penyimpanan terenkripsi untuk data sensitif (isi catatan).
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String _keyForNote(String noteId) => 'note_content_$noteId';

  /// Menyimpan isi catatan secara terenkripsi berdasarkan [noteId].
  Future<void> saveContent(String noteId, String content) async {
    await _storage.write(key: _keyForNote(noteId), value: content);
  }

  /// Membaca isi catatan terenkripsi berdasarkan [noteId].
  Future<String?> getContent(String noteId) async {
    return await _storage.read(key: _keyForNote(noteId));
  }

  /// Menghapus isi catatan terenkripsi berdasarkan [noteId].
  Future<void> deleteContent(String noteId) async {
    await _storage.delete(key: _keyForNote(noteId));
  }
}