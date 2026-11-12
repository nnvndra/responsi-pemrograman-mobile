import 'package:flutter/material.dart';

/// Widget tampilan kosong ketika daftar catatan belum tersedia.
class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({
    super.key,
    this.message = 'Belum ada catatan kuliah.\nTekan tombol + untuk menambah.',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}