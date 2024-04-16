class ProgramRelawanModel {
  final int idProgramRelawan;
  final String namaProgramRelawan;
  final String deskripsiSingkatRelawan;
  final int targetRelawan;
  final String tglPelaksanaan;
  final String lokasiProgram;
  final String deskripsiLengkapRelawan;
  final String fotoPRelawan;
  final String statusProgramRelawan;
  final String tglPRelawan;
  final String lokasiAwal;
  final String penanggungJawab;
  final String tenggatWaktu;
  final String buktiPelaksanaan;
  final String kategoriRelawan;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  ProgramRelawanModel({
    required this.idProgramRelawan,
    required this.namaProgramRelawan,
    required this.deskripsiSingkatRelawan,
    required this.targetRelawan,
    required this.tglPelaksanaan,
    required this.lokasiProgram,
    required this.deskripsiLengkapRelawan,
    required this.fotoPRelawan,
    required this.statusProgramRelawan,
    required this.tglPRelawan,
    required this.lokasiAwal,
    required this.penanggungJawab,
    required this.tenggatWaktu,
    required this.buktiPelaksanaan,
    required this.kategoriRelawan,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ProgramRelawanModel.fromJson(Map<String, dynamic> json) {
    return ProgramRelawanModel(
      idProgramRelawan: json['id_program_relawan'],
      namaProgramRelawan: json['nama_program_relawan'],
      deskripsiSingkatRelawan: json['deskripsi_singkat_relawan'],
      targetRelawan: json['target_relawan'],
      tglPelaksanaan: json['tgl_pelaksanaan'],
      lokasiProgram: json['lokasi_program'],
      deskripsiLengkapRelawan: json['deskripsi_lengkap_relawan'],
      fotoPRelawan: json['foto_p_relawan'],
      statusProgramRelawan: json['status_program_relawan'],
      tglPRelawan: json['tgl_prelawan'],
      lokasiAwal: json['lokasi_awal'],
      penanggungJawab: json['penanggung_jawab'],
      tenggatWaktu: json['tenggat_waktu'],
      buktiPelaksanaan: json['bukti_pelaksanaan'],
      kategoriRelawan: json['kategori_relawan'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}
