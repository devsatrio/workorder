class AllTodoData {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AllTodoData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  AllTodoData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
