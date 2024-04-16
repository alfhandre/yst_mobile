class KegiatanModel {
  final int idBerita;
  final String judulBerita;
  final String tglKejadian;
  final String isiBerita;
  final String gambarBerita;
  final String tglPenulisan;
  final int kategoriBerita;
  final int statusBerita;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  KegiatanModel({
    required this.idBerita,
    required this.judulBerita,
    required this.tglKejadian,
    required this.isiBerita,
    required this.gambarBerita,
    required this.tglPenulisan,
    required this.kategoriBerita,
    required this.statusBerita,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory KegiatanModel.fromJson(Map<String, dynamic> json) {
    return KegiatanModel(
      idBerita: json['id_berita'],
      judulBerita: json['judul_berita'],
      tglKejadian: json['tgl_kejadian'],
      isiBerita: json['isi_berita'],
      gambarBerita: json['gambar_berita'],
      tglPenulisan: json['tgl_penulisan'],
      kategoriBerita: json['kategori_berita'],
      statusBerita: json['status_berita'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}
