import '../utils/api.dart';

class ProdukResponse {
  bool? _success;
  String? _message;
  List<Produk>? _data;

  ProdukResponse({bool? success, String? message, List<Produk>? data}) {
    _success = success;
    _message = message;
    _data = data;
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;

  String? get message => _message;
  set message(String? message) => _message = message;

  List<Produk>? get data => _data;
  set data(List<Produk>? data) => _data = data;

  ProdukResponse.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <Produk>[];
      json['data'].forEach((v) {
        _data!.add(Produk.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = _success;
    data['message'] = _message;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Produk {
  int? _id;
  String? _namaProduk;
  String? _deskripsi;
  int? _harga;
  int? _stok;
  String? _image;
  int? _idKategori;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;
  Kategori? _kategori;

  Produk({
    int? id,
    String? namaProduk,
    String? deskripsi,
    int? harga,
    int? stok,
    String? image,
    int? idKategori,
    String? createdAt,
    String? updatedAt,
    String? imageUrl,
    Kategori? kategori,
  }) {
    _id = id;
    _namaProduk = namaProduk;
    _deskripsi = deskripsi;
    _harga = harga;
    _stok = stok;
    _image = image;
    _idKategori = idKategori;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
    _kategori = kategori;
  }

  int? get id => _id;
  String? get namaProduk => _namaProduk;
  String? get deskripsi => _deskripsi;
  int? get harga => _harga;
  int? get stok => _stok;
  String? get image => _image;
  int? get idKategori => _idKategori;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;
  Kategori? get kategori => _kategori;

  Produk.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _namaProduk = json['nama_produk'];
    _deskripsi = json['deskripsi'];
    _harga = json['harga'];
    _stok = json['stok'];
    _image = json['image'];
    _idKategori = json['id_kategori'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = _image != null ? '${BaseUrl.images}$_image' : null;
    _kategori = json['kategori'] != null
        ? Kategori.fromJson(json['kategori'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['nama_produk'] = _namaProduk;
    data['deskripsi'] = _deskripsi;
    data['harga'] = _harga;
    data['stok'] = _stok;
    data['image'] = _image;
    data['id_kategori'] = _idKategori;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['image_url'] = _imageUrl;
    if (_kategori != null) {
      data['kategori'] = _kategori!.toJson();
    }
    return data;
  }
}

class Kategori {
  int? _id;
  String? _namaKategori;
  String? _createdAt;
  String? _updatedAt;

  Kategori({
    int? id,
    String? namaKategori,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _namaKategori = namaKategori;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get namaKategori => _namaKategori;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Kategori.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _namaKategori = json['nama_kategori'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['nama_kategori'] = _namaKategori;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
