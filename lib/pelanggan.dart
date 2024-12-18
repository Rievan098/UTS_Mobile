class Pelanggan {
  final String kode;
  final String nama;

  Pelanggan({
    required this.kode,
    required this.nama,
  });

  @override
  String toString() {
    return 'Pelanggan(kode: $kode, nama: $nama)';
  }
}
