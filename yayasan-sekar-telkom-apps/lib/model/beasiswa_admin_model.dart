class BeasiswaAdminModel {
  final int idBeasiswa;
  int? userNik;
  String? tgl;
  String? namaAnak1;
  String? namaAnak2;
  String? namaAnak3;
  String? jenjangPendidikan1;
  String? jenjangPendidikan2;
  String? jenjangPendidikan3;
  int? nominal1;
  int? nominal2;
  int? nominal3;
  String? namaBank1;
  String? namaBank2;
  String? namaBank3;
  String? nomorRekening1;
  String? nomorRekening2;
  String? nomorRekening3;
  int? totalNominal;
  String? keterangan;
  String? status;
  String? isApprove;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? approvedAt;
  String? approvedBy;
  String? nama;
  int? jumlahPengApprove;

  BeasiswaAdminModel({
    required this.idBeasiswa,
    this.userNik,
    this.tgl,
    this.namaAnak1,
    this.namaAnak2,
    this.namaAnak3,
    this.jenjangPendidikan1,
    this.jenjangPendidikan2,
    this.jenjangPendidikan3,
    this.nominal1,
    this.nominal2,
    this.nominal3,
    this.namaBank1,
    this.namaBank2,
    this.namaBank3,
    this.nomorRekening1,
    this.nomorRekening2,
    this.nomorRekening3,
    this.totalNominal,
    this.keterangan,
    this.status,
    this.isApprove,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.nama,
    this.jumlahPengApprove,
  });

  factory BeasiswaAdminModel.fromJson(Map<String, dynamic> json) {
    return BeasiswaAdminModel(
        idBeasiswa: json['id_beasiswa'],
        userNik: json['user_nik'],
        tgl: json['tgl'],
        namaAnak1: json['nama_anak1'],
        namaAnak2: json['nama_anak2'],
        namaAnak3: json['nama_anak3'],
        jenjangPendidikan1: json['jenjang_pendidikan1'],
        jenjangPendidikan2: json['jenjang_pendidikan2'],
        jenjangPendidikan3: json['jenjang_pendidikan3'],
        nominal1: json['nominal_1'],
        nominal2: json['nominal_2'],
        nominal3: json['nominal_3'],
        namaBank1: json['nama_bank1'],
        namaBank2: json['nama_bank2'],
        namaBank3: json['nama_bank3'],
        nomorRekening1: json['nomor_rekening1'],
        nomorRekening2: json['nomor_rekening2'],
        nomorRekening3: json['nomor_rekening3'],
        totalNominal: json['total_nominal'],
        keterangan: json['keterangan'],
        status: json['status'],
        isApprove: json['is_approve'],
        createdAt: json['created_at'] ?? '',
        updatedAt: json['updated_at'] ?? '',
        createdBy: json['created_by'] ?? '',
        updatedBy: json['updated_by'] ?? '',
        approvedAt: json['approved_at'],
        approvedBy: json['approved_by'],
        nama: json['nama_pengajuan_beasiswa'],
        jumlahPengApprove: json['jumlah_peng_approve']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_beasiswa': idBeasiswa,
      'user_nik': userNik,
      'tgl': tgl,
      'nama_anak1': namaAnak1,
      'nama_anak2': namaAnak2,
      'nama_anak3': namaAnak3,
      'jenjang_pendidikan1': jenjangPendidikan1,
      'jenjang_pendidikan2': jenjangPendidikan2,
      'jenjang_pendidikan3': jenjangPendidikan3,
      'nominal_1': nominal1,
      'nominal_2': nominal2,
      'nominal_3': nominal3,
      'nama_bank1': namaBank1,
      'nama_bank2': namaBank2,
      'nama_bank3': namaBank3,
      'nomor_rekening1': nomorRekening1,
      'nomor_rekening2': nomorRekening2,
      'nomor_rekening3': nomorRekening3,
      'total_nominal': totalNominal,
      'keterangan': keterangan,
      'status': status,
      'is_approve': isApprove,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'approved_at': approvedAt,
      'approved_by': approvedBy,
      'nama': nama,
      'jumlah_peng_approve': jumlahPengApprove,
    };
  }
}
