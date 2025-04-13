class ImageResponse {
  bool _success;
  String _message;
  List<ImageData> _data;

  ImageResponse({
    bool success = false,
    String message = '',
    List<ImageData>? data,
  })  : _success = success,
        _message = message,
        _data = data ?? [];

  bool get success => _success;
  String get message => _message;
  List<ImageData> get data => _data;

  ImageResponse.fromJson(Map<String, dynamic> json)
      : _success = json['success'] == true,
        _message = json['message']?.toString() ?? '',
        _data = (json['data'] as List<dynamic>?)
                ?.map((item) => ImageData.fromJson(item))
                .toList() ??
            [];

  Map<String, dynamic> toJson() => {
        'success': _success,
        'message': _message,
        'data': _data.map((item) => item.toJson()).toList(),
      };
}

class ImageData {
  int? id;
  String? image;
  int? idProduk;
  String? createdAt;
  String? updatedAt;
  String? imageUrl; // <- ini langsung dari API

  ImageData({
    this.id,
    this.image,
    this.idProduk,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json['id'],
        image: json['image'],
        idProduk: json['id_produk'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        imageUrl: json['image_url'], // <- ambil langsung dari API
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'id_produk': idProduk,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'image_url': imageUrl,
      };
}
