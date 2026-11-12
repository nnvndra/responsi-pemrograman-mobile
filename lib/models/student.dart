/// Model data untuk merepresentasikan informasi profil mahasiswa.
class Student {
  final String name;
  final String nim;
  final String programStudi;
  final String email;

  const Student({
    required this.name,
    required this.nim,
    required this.programStudi,
    required this.email,
  });

  /// Membuat salinan objek [Student] dengan pembaruan field tertentu.
  Student copyWith({
    String? name,
    String? nim,
    String? programStudi,
    String? email,
  }) {
    return Student(
      name: name ?? this.name,
      nim: nim ?? this.nim,
      programStudi: programStudi ?? this.programStudi,
      email: email ?? this.email,
    );
  }
}