class KategoriResponse {
  bool? success;
  String? message;
  List<Kategori>? data;

  KategoriResponse({this.success, this.message, this.data});

  factory KategoriResponse.fromJson(Map<String, dynamic> json) {
    return KategoriResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Kategori.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class Kategori {
  int? id;
  String? namaKategori;

  Kategori({this.id, this.namaKategori});

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'] as int?,
      namaKategori: json['nama_kategori'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
    };
  }
}
