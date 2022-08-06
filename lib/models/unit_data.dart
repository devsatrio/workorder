class DataUnit {
  List<Data>? data;
  String? sts;

  DataUnit({this.data, this.sts});

  DataUnit.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? unit;
  String? namaUnit;
  String? kepala;

  Data({this.id, this.unit, this.namaUnit, this.kepala});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit = json['unit'];
    namaUnit = json['nama_unit'];
    kepala = json['kepala'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unit'] = this.unit;
    data['nama_unit'] = this.namaUnit;
    data['kepala'] = this.kepala;
    return data;
  }
}
