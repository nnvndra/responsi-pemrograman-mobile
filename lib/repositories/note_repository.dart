import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../models/note.dart';
import '../services/secure_storage_service.dart';

class NoteRepository {
  static const String _notesMetadataKey = 'notes_metadata_list';
  final SecureStorageService _secureStorage;

  NoteRepository({SecureStorageService? secureStorage})
      : _secureStorage = secureStorage ?? SecureStorageService();

  Future<List<Note>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_notesMetadataKey);
    if (jsonString == null) return [];

    final List<dynamic> decodedList = jsonDecode(jsonString);
    final List<Note> notes = [];

    for (final item in decodedList) {
      final map = item as Map<String, dynamic>;
      final id = map['id'] as String;
      final content = await _secureStorage.getContent(id) ?? '';
      notes.add(Note.fromMetadataJson(map, content: content));
    }

    return notes;
  }

  Future<void> addNote(Note note) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNotes = await getAllNotes();
    existingNotes.insert(0, note);

    final metadataList = existingNotes.map((n) => n.toMetadataJson()).toList();
    await prefs.setString(_notesMetadataKey, jsonEncode(metadataList));
    await _secureStorage.saveContent(note.id, note.content);
  }

  Future<void> deleteNote(String noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNotes = await getAllNotes();
    existingNotes.removeWhere((n) => n.id == noteId);

    final metadataList = existingNotes.map((n) => n.toMetadataJson()).toList();
    await prefs.setString(_notesMetadataKey, jsonEncode(metadataList));
    await _secureStorage.deleteContent(noteId);
  }

  // Menggunakan List<dynamic> untuk menghindari konflik karakter generik '>'
  Future<List<dynamic>> fetchPublicPosts() async {
    final uri = Uri.parse('${AppConfig.baseUrl}/posts?_limit=5');
    try {
      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'X-Api-Key': AppConfig.apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw HttpException('Server error: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } on TimeoutException {
      throw Exception('Waktu koneksi habis.');
    } catch (e) {
      throw Exception('Gagal memuat data.');
    }
  }
}