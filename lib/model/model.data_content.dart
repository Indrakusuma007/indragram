class ModelDataContent {
  final String? urlPhoto;
  final String? urlContent;
  final String? nama;
  final String? lokasi;
  final int harga;

  ModelDataContent({required this.urlPhoto, required this.harga, required this.urlContent, required this.nama, required this.lokasi});
  // Metode untuk membuat objek User dari Map (misalnya, dari Firestore)
  factory ModelDataContent.fromMap(Map<String, dynamic> data) {
    return ModelDataContent(
      urlPhoto: data['url_photo'],
      urlContent: data['url_content'],
      nama: data['nama'],
      lokasi: data['lokasi'],
      harga: data['harga'] ?? 0,
    );
  }
}
