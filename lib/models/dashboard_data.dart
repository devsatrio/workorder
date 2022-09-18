class DataDashboard {
  int? orderToday;
  int? orderFinishToday;
  String? sts;

  DataDashboard({this.orderToday, this.orderFinishToday, this.sts});

  DataDashboard.fromJson(Map<String, dynamic> json) {
    orderToday = json['order_today'];
    orderFinishToday = json['order_finish_today'];
    sts = json['sts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_today'] = this.orderToday;
    data['order_finish_today'] = this.orderFinishToday;
    data['sts'] = this.sts;
    return data;
  }
}
