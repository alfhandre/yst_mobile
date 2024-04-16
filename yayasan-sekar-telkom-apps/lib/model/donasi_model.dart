class ProgramDonasiModel {
  final int idProgramDonasi;
  final String namaProgramDonasi;
  final String deskripsiSingkatDonasi;
  final int targetDana;
  final String deskripsiLengkapDonasi;
  final String fotoPDonasi;
  final String tglPDonasi;
  final String tglSelesai;
  final String statusProgramDonasi;
  final String penerimaDonasi;
  final String buktiPenyaluran;
  final String tglPenyaluran;
  final String penanggungJawab;
  final int jangkaWaktu;
  final String kategoriDonasi;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  ProgramDonasiModel({
    required this.idProgramDonasi,
    required this.namaProgramDonasi,
    required this.deskripsiSingkatDonasi,
    required this.targetDana,
    required this.deskripsiLengkapDonasi,
    required this.fotoPDonasi,
    required this.tglPDonasi,
    required this.tglSelesai,
    required this.statusProgramDonasi,
    required this.penerimaDonasi,
    required this.buktiPenyaluran,
    required this.tglPenyaluran,
    required this.penanggungJawab,
    required this.jangkaWaktu,
    required this.kategoriDonasi,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory ProgramDonasiModel.fromJson(Map<String, dynamic> json) {
    return ProgramDonasiModel(
      idProgramDonasi: json['id_program_donasi'],
      namaProgramDonasi: json['nama_program_donasi'],
      deskripsiSingkatDonasi: json['deskripsi_singkat_donasi'],
      targetDana: json['target_dana'],
      deskripsiLengkapDonasi: json['deskripsi_lengkap_donasi'],
      fotoPDonasi: json['foto_p_donasi'],
      tglPDonasi: json['tgl_pdonasi'],
      tglSelesai: json['tgl_selesai'],
      statusProgramDonasi: json['status_program_donasi'],
      penerimaDonasi: json['penerima_donasi'],
      buktiPenyaluran: json['bukti_penyaluran'],
      tglPenyaluran: json['tgl_penyaluran'],
      penanggungJawab: json['penanggung_jawab'],
      jangkaWaktu: json['jangka_waktu'],
      kategoriDonasi: json['kategori_donasi'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}
