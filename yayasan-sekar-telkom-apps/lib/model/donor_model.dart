class DonorModel {
  //  final String idRelawan;
  //      final String statusRelawan;
  //      final String idUser;
  // final int idProgramRelawan;
  // final String namaProgramRelawan;
  // final String tglPelaksanaan;
  final String domisili;
  final String namaLengkap;
  final int noHp;
  final String tgldaftar;
  final String email;
  final int noKtp;
  final int noKaryawan;
  final String loker;
  // final String createdAt;
  // final String updatedAt;
  // final String createdBy;
  // final String updatedBy;

  DonorModel({
    required this.domisili,
    required this.namaLengkap,
    required this.noHp,
    required this.tgldaftar,
    required this.email,
    required this.noKaryawan,
    required this.noKtp,
    required this.loker,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.createdBy,
    // required this.updatedBy,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      domisili: json['domisili'],
      namaLengkap: json['nama_lengkap'],
      noHp: json['no_hp'],
      tgldaftar: json['tgl_daftar'],
      email: json['email'],
      noKaryawan: json['no_karyawan'],
      noKtp: json['no_ktp'],
      loker: json['loker'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      // createdBy: json['created_by'],
      // updatedBy: json['updated_by'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'domisili': domisili,
      'nama_lengkap': namaLengkap,
      'no_hp': noHp,
      'tgl_daftar': tgldaftar,
      'email': email,
      'no_karyawan': noKaryawan,
      'no_ktp': noKtp,
      'loker': loker,
      // 'created_at': createdAt,
      // 'updated_at': updatedAt,
      // 'created_by': createdBy,
      // 'updated_by': updatedBy,
    };
  }
}
