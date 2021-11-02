/// status : true
/// code : 200
/// message : "Get Data Success!"
/// data : {"ringkasan_transaksi":{"total_all":40000,"total_cash":40000,"cancel":null,"all_disc":null,"neto":null,"success":1},"penjualan_produk":[{"name":"Kopi Pro","count":1,"sum":10000},{"name":"ciki oroduk","count":3,"sum":10000}],"payment_method":[{"payment_method_alias":"CASH","PAYMENT_METHOD_ID":null,"total":40000,"count":1}]}

class ReportTransaction {
  ReportTransaction({
      this.status, 
      this.code, 
      this.message, 
      this.data,});

  ReportTransaction.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? DataReport.fromJson(json['data']) : null;
  }
  bool? status;
  int? code;
  String? message;
  DataReport? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// ringkasan_transaksi : {"total_all":40000,"total_cash":40000,"cancel":null,"all_disc":null,"neto":null,"success":1}
/// penjualan_produk : [{"name":"Kopi Pro","count":1,"sum":10000},{"name":"ciki oroduk","count":3,"sum":10000}]
/// payment_method : [{"payment_method_alias":"CASH","PAYMENT_METHOD_ID":null,"total":40000,"count":1}]

class DataReport {
  DataReport({
      this.ringkasanTransaksi, 
      this.penjualanProduk, 
      this.paymentMethod,});

  DataReport.fromJson(dynamic json) {
    ringkasanTransaksi = json['ringkasan_transaksi'] != null ? Ringkasan_transaksi.fromJson(json['ringkasan_transaksi']) : null;
    if (json['penjualan_produk'] != null) {
      penjualanProduk = [];
      json['penjualan_produk'].forEach((v) {
        penjualanProduk?.add(Penjualan_produk.fromJson(v));
      });
    }
    if (json['payment_method'] != null) {
      paymentMethod = [];
      json['payment_method'].forEach((v) {
        paymentMethod?.add(Payment_method.fromJson(v));
      });
    }
  }
  Ringkasan_transaksi? ringkasanTransaksi;
  List<Penjualan_produk>? penjualanProduk;
  List<Payment_method>? paymentMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ringkasanTransaksi != null) {
      map['ringkasan_transaksi'] = ringkasanTransaksi?.toJson();
    }
    if (penjualanProduk != null) {
      map['penjualan_produk'] = penjualanProduk?.map((v) => v.toJson()).toList();
    }
    if (paymentMethod != null) {
      map['payment_method'] = paymentMethod?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// payment_method_alias : "CASH"
/// PAYMENT_METHOD_ID : null
/// total : 40000
/// count : 1

class Payment_method {
  Payment_method({
      this.paymentMethodAlias, 
      this.paymentmethodid, 
      this.total, 
      this.count,});

  Payment_method.fromJson(dynamic json) {
    paymentMethodAlias = json['payment_method_alias'];
    paymentmethodid = json['PAYMENT_METHOD_ID'];
    total = json['total'];
    count = json['count'];
  }
  String? paymentMethodAlias;
  dynamic paymentmethodid;
  int? total;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_method_alias'] = paymentMethodAlias;
    map['PAYMENT_METHOD_ID'] = paymentmethodid;
    map['total'] = total;
    map['count'] = count;
    return map;
  }

}

/// name : "Kopi Pro"
/// count : 1
/// sum : 10000

class Penjualan_produk {
  Penjualan_produk({
      this.name, 
      this.count, 
      this.sum,});

  Penjualan_produk.fromJson(dynamic json) {
    name = json['name'];
    count = json['count'];
    sum = json['sum'];
  }
  String? name;
  int? count;
  int? sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['count'] = count;
    map['sum'] = sum;
    return map;
  }

}

/// total_all : 40000
/// total_cash : 40000
/// cancel : null
/// all_disc : null
/// neto : null
/// success : 1

class Ringkasan_transaksi {
  Ringkasan_transaksi({
      this.totalAll, 
      this.totalCash, 
      this.cancel, 
      this.allDisc, 
      this.neto, 
      this.success,});

  Ringkasan_transaksi.fromJson(dynamic json) {
    totalAll = json['total_all'] ?? 0;
    totalCash = json['total_cash'] ?? 0;
    cancel = json['cancel'] ?? 0;
    allDisc = json['all_disc'] ?? 0;
    neto = json['neto'] ?? 0;
    success = json['success'] ?? 0;
  }
  int? totalAll;
  int? totalCash;
  dynamic cancel;
  dynamic allDisc;
  dynamic neto;
  int? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_all'] = totalAll;
    map['total_cash'] = totalCash;
    map['cancel'] = cancel;
    map['all_disc'] = allDisc;
    map['neto'] = neto;
    map['success'] = success;
    return map;
  }

}