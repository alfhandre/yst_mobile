class BeritaModel {
  final int id;
  final String title;
  final String eventDate;
  final String content;
  final String imageUrl;
  final String writingDate;
  final int category;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String createdBy;
  final String updatedBy;

  BeritaModel({
    required this.id,
    required this.title,
    required this.eventDate,
    required this.content,
    required this.imageUrl,
    required this.writingDate,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id_berita'],
      title: json['judul_berita'],
      eventDate: json['tgl_kejadian'],
      content: json['isi_berita'],
      imageUrl: json['gambar_berita'],
      writingDate: json['tgl_penulisan'],
      category: json['kategori_berita'],
      status: json['status_berita'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}
