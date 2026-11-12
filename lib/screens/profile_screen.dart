import 'package:flutter/material.dart';
import '../models/student.dart';
import '../providers/app_provider.dart';
import '../utils/validators.dart';
import '../widgets/profile_card.dart';

/// Halaman detail dan pengeditan profil mahasiswa.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showEditDialog(BuildContext context, Student currentStudent) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: currentStudent.name);
    final nimCtrl = TextEditingController(text: currentStudent.nim);
    final prodiCtrl = TextEditingController(text: currentStudent.programStudi);
    final emailCtrl = TextEditingController(text: currentStudent.email);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profil Mahasiswa'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nimCtrl,
                  decoration: const InputDecoration(labelText: 'NIM'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'NIM wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: prodiCtrl,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Prodi wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'Masukkan email valid'
                      : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final updated = currentStudent.copyWith(
                  name: Validators.sanitize(nameCtrl.text),
                  nim: Validators.sanitize(nimCtrl.text),
                  programStudi: Validators.sanitize(prodiCtrl.text),
                  email: Validators.sanitize(emailCtrl.text),
                );
                AppProvider.of(context).updateStudent(updated);
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil berhasil diperbarui')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = AppProvider.of(context).student;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ProfileCard(
          student: student,
          onEditPressed: () => _showEditDialog(context, student),
        ),
      ),
    );
  }
}