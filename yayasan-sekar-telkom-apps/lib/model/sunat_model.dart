class SunatModel {
  final String namaAnak;
  final String tempatLahir;
  final String tanggalLahir;
  final int umur;
  final String alamat;
  final String sekolah;
  final int kelas;
  final String riwayatPenyakit;
  final String namaAyah;
  final String pekerjaanAyah;
  final String namaIbu;
  final String pekerjaanIbu;
  final String noHp;

  SunatModel({
    required this.namaAnak,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.umur,
    required this.alamat,
    required this.sekolah,
    required this.kelas,
    required this.riwayatPenyakit,
    required this.namaAyah,
    required this.pekerjaanAyah,
    required this.namaIbu,
    required this.pekerjaanIbu,
    required this.noHp,
  });

  factory SunatModel.fromJson(Map<String, dynamic> json) {
    return SunatModel(
      namaAnak: json['nama_anak'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: json['tanggal_lahir'],
      umur: json['umur'],
      alamat: json['alamat'],
      sekolah: json['sekolah'],
      kelas: json['kelas'],
      riwayatPenyakit: json['riwayat_penyakit'],
      namaAyah: json['nama_ayah'],
      pekerjaanAyah: json['pekerjaan_ayah'],
      namaIbu: json['nama_ibu'],
      pekerjaanIbu: json['pekerjaan_ibu'],
      noHp: json['no_hp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_anak': namaAnak,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'umur': umur,
      'alamat': alamat,
      'sekolah': sekolah,
      'kelas': kelas,
      'riwayat_penyakit': riwayatPenyakit,
      'nama_ayah': namaAyah,
      'pekerjaan_ayah': pekerjaanAyah,
      'nama_ibu': namaIbu,
      'pekerjaan_ibu': pekerjaanIbu,
      'no_hp': noHp,
    };
  }
}
