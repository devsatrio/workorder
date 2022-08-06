class DataBarang {
  List<Data>? data;
  String? sts;

  DataBarang({this.data, this.sts});

  DataBarang.fromJson(Map<String, dynamic> json) {
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
  int? idwl;
  String? jenisWork;
  String? unit;
  String? status;

  Data({this.idwl, this.jenisWork, this.unit, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    idwl = json['idwl'];
    jenisWork = json['jenis_work'];
    unit = json['unit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idwl'] = this.idwl;
    data['jenis_work'] = this.jenisWork;
    data['unit'] = this.unit;
    data['status'] = this.status;
    return data;
  }
}
