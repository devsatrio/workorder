class logindata {
  List<Data>? data;
  String? sts;

  logindata({this.data, this.sts});

  logindata.fromJson(Map<String, dynamic> json) {
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
  String? bagian;
  String? unit;
  String? user;
  String? pass;

  Data({this.id, this.bagian, this.unit, this.user, this.pass});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bagian = json['bagian'];
    unit = json['unit'];
    user = json['user'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bagian'] = this.bagian;
    data['unit'] = this.unit;
    data['user'] = this.user;
    data['pass'] = this.pass;
    return data;
  }
}
