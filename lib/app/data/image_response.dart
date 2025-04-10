class ImageProduk {
  final int? id;
  final String? imageUrl;
  final int? idProduk;

  ImageProduk({this.id, this.imageUrl, this.idProduk});

  factory ImageProduk.fromJson(Map<String, dynamic> json) {
    return ImageProduk(
      id: json['id'],
      imageUrl: json['image_url'],
      idProduk: json['id_produk'],
    );
  }
}
