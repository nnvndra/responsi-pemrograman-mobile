import 'package:flutter/material.dart';
import '../models/note.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';

/// Halaman form untuk menambahkan catatan kuliah baru dengan validasi input.
class NoteFormScreen extends StatefulWidget {
  const NoteFormScreen({super.key});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final sanitizedTitle = Validators.sanitize(_titleController.text);
    final sanitizedContent = Validators.sanitize(_contentController.text);

    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: sanitizedTitle,
      createdAt: DateTime.now(),
      content: sanitizedContent,
    );

    await AppProvider.of(context).addNote(newNote);

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan Kuliah')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Catatan',
                  hintText: 'Contoh: Pertemuan 6 - Secure Storage',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Isi Catatan',
                  hintText: 'Tuliskan ringkasan materi kuliah...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: Validators.validateContent,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _isSaving ? null : _submitForm,
                icon: const Icon(Icons.save),
                label: Text(_isSaving ? 'Menyimpan...' : 'Simpan Catatan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}