class data_work_order {
  List<Data>? data;
  String? sts;

  data_work_order({this.data, this.sts});

  data_work_order.fromJson(Map<String, dynamic> json) {
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
  String? idwo;
  String? tglOrder;
  String? idUnit;
  String? unitOrder;
  String? tujuan;
  String? kategori;
  String? jenis;
  String? noInventaris;
  String? namaBarang;
  String? detailBarang;
  String? permasalahan;
  String? status;
  String? tglExecute;
  String? pelaksana1;
  String? pelaksana2;
  String? pelaksana3;
  String? pelaksana4;
  String? tindakan;
  String? hasil;
  String? tglFinish;
  String? catatanPetugas;
  String? tglIn;
  String? userIn;
  String? tglUp;
  String? userUp;
  String? msg;

  Data(
      {this.idwo,
      this.tglOrder,
      this.idUnit,
      this.unitOrder,
      this.tujuan,
      this.kategori,
      this.jenis,
      this.noInventaris,
      this.namaBarang,
      this.detailBarang,
      this.permasalahan,
      this.status,
      this.tglExecute,
      this.pelaksana1,
      this.pelaksana2,
      this.pelaksana3,
      this.pelaksana4,
      this.tindakan,
      this.hasil,
      this.tglFinish,
      this.catatanPetugas,
      this.tglIn,
      this.userIn,
      this.tglUp,
      this.userUp,
      this.msg});

  Data.fromJson(Map<String, dynamic> json) {
    idwo = json['idwo'];
    tglOrder = json['tgl_order'];
    idUnit = json['id_unit'];
    unitOrder = json['unit_order'];
    tujuan = json['tujuan'];
    kategori = json['kategori'];
    jenis = json['jenis'];
    noInventaris = json['no_inventaris'];
    namaBarang = json['nama_barang'];
    detailBarang = json['detail_barang'];
    permasalahan = json['permasalahan'];
    status = json['status'];
    tglExecute = json['tgl_execute'];
    pelaksana1 = json['pelaksana1'];
    pelaksana2 = json['pelaksana2'];
    pelaksana3 = json['pelaksana3'];
    pelaksana4 = json['pelaksana4'];
    tindakan = json['tindakan'];
    hasil = json['hasil'];
    tglFinish = json['tgl_finish'];
    catatanPetugas = json['catatan_petugas'];
    tglIn = json['tgl_in'];
    userIn = json['user_in'];
    tglUp = json['tgl_up'];
    userUp = json['user_up'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idwo'] = this.idwo;
    data['tgl_order'] = this.tglOrder;
    data['id_unit'] = this.idUnit;
    data['unit_order'] = this.unitOrder;
    data['tujuan'] = this.tujuan;
    data['kategori'] = this.kategori;
    data['jenis'] = this.jenis;
    data['no_inventaris'] = this.noInventaris;
    data['nama_barang'] = this.namaBarang;
    data['detail_barang'] = this.detailBarang;
    data['permasalahan'] = this.permasalahan;
    data['status'] = this.status;
    data['tgl_execute'] = this.tglExecute;
    data['pelaksana1'] = this.pelaksana1;
    data['pelaksana2'] = this.pelaksana2;
    data['pelaksana3'] = this.pelaksana3;
    data['pelaksana4'] = this.pelaksana4;
    data['tindakan'] = this.tindakan;
    data['hasil'] = this.hasil;
    data['tgl_finish'] = this.tglFinish;
    data['catatan_petugas'] = this.catatanPetugas;
    data['tgl_in'] = this.tglIn;
    data['user_in'] = this.userIn;
    data['tgl_up'] = this.tglUp;
    data['user_up'] = this.userUp;
    data['msg'] = this.msg;
    return data;
  }
}
