import 'package:flutter/material.dart';
import '../models/note.dart';
import '../models/student.dart';
import '../repositories/note_repository.dart';

/// InheritedWidget untuk mendistribusikan state profil mahasiswa dan catatan kuliah.
class AppProvider extends InheritedWidget {
  final Student student;
  final List<Note> notes;
  final bool isLoading;
  final Function(Student) updateStudent;
  final Future<void> Function(Note) addNote;
  final Future<void> Function(String) deleteNote;

  const AppProvider({
    super.key,
    required this.student,
    required this.notes,
    required this.isLoading,
    required this.updateStudent,
    required this.addNote,
    required this.deleteNote,
    required super.child,
  });

  /// Mengambil instance [AppProvider] terdekat dari BuildContext.
  static AppProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(provider != null, 'AppProvider tidak ditemukan di widget tree');
    return provider!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return student != oldWidget.student ||
        notes != oldWidget.notes ||
        isLoading != oldWidget.isLoading;
  }
}

/// StatefulWidget pembungkus yang mengelola perubahan state aplikasi.
class AppProviderWrapper extends StatefulWidget {
  final Widget child;

  const AppProviderWrapper({super.key, required this.child});

  @override
  State<AppProviderWrapper> createState() => _AppProviderWrapperState();
}

class _AppProviderWrapperState extends State<AppProviderWrapper> {
  final NoteRepository _repository = NoteRepository();
  bool _isLoading = true;
  List<Note> _notes = [];

  Student _student = const Student(
    name: 'Mahasiswa Amikom',
    nim: '25.11.6541',
    programStudi: 'S1 Informatika',
    email: 'n.rahmad@students.amikom.ac.id',
  );

  @override
  void initState() {
    super.initState();
    _loadInitialNotes();
  }

  Future<void> _loadInitialNotes() async {
    final loadedNotes = await _repository.getAllNotes();
    if (mounted) {
      setState(() {
        _notes = loadedNotes;
        _isLoading = false;
      });
    }
  }

  void _updateStudent(Student updated) {
    setState(() {
      _student = updated;
    });
  }

  Future<void> _addNote(Note note) async {
    await _repository.addNote(note);
    final updatedList = await _repository.getAllNotes();
    if (mounted) {
      setState(() {
        _notes = updatedList;
      });
    }
  }

  Future<void> _deleteNote(String noteId) async {
    await _repository.deleteNote(noteId);
    final updatedList = await _repository.getAllNotes();
    if (mounted) {
      setState(() {
        _notes = updatedList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      student: _student,
      notes: _notes,
      isLoading: _isLoading,
      updateStudent: _updateStudent,
      addNote: _addNote,
      deleteNote: _deleteNote,
      child: widget.child,
    );
  }
}