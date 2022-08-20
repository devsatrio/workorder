class DataPelaksanan {
  List<Data>? data;
  String? sts;

  DataPelaksanan({this.data, this.sts});

  DataPelaksanan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    sts = json['sts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['sts'] = this.sts;
    return data;
  }
}

class Data {
  int? id;
  String? pelaksana;
  String? kategori;

  Data({this.id, this.pelaksana, this.kategori});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pelaksana = json['pelaksana'];
    kategori = json['kategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pelaksana'] = this.pelaksana;
    data['kategori'] = this.kategori;
    return data;
  }
}
