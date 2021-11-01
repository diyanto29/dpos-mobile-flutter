/// status : true
/// code : 200
/// message : "Get Data Success!"
/// data : {"total_transaction":142,"total_income_transaction":12173720,"total_product":342,"total_benefit":11751000,"products":[{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":56},{"PRODUCT_NAME":"produk423","PRODUCT_SOLD":52},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":52},{"PRODUCT_NAME":"produk 123","PRODUCT_SOLD":24},{"PRODUCT_NAME":"test123","PRODUCT_SOLD":20},{"PRODUCT_NAME":"xova","PRODUCT_SOLD":18},{"PRODUCT_NAME":"produk333","PRODUCT_SOLD":16},{"PRODUCT_NAME":"test123","PRODUCT_SOLD":11},{"PRODUCT_NAME":"produk423","PRODUCT_SOLD":8},{"PRODUCT_NAME":"Geprek","PRODUCT_SOLD":6},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":5},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":5},{"PRODUCT_NAME":"Mike GOreng","PRODUCT_SOLD":5},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":4},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":2},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":1}],"payment_method":[{"payment_method":"Cash","total_transaction":70,"nominal_transaction":"7122300"},{"payment_method":"Link Aja","total_transaction":12,"nominal_transaction":"268500"},{"payment_method":"SHOPPE","total_transaction":1,"nominal_transaction":"50000"},{"payment_method":"TOKOPEDIA","total_transaction":2,"nominal_transaction":"62000"},{"payment_method":"GRAB-FOOD","total_transaction":2,"nominal_transaction":"24000"},{"payment_method":"BCA","total_transaction":2,"nominal_transaction":"100000"},{"payment_method":"DANA","total_transaction":7,"nominal_transaction":"743760"},{"payment_method":"QRIS","total_transaction":4,"nominal_transaction":"1148000"},{"payment_method":"GO-PAY","total_transaction":1,"nominal_transaction":"136500"}]}

class ReportTranasaction {
  ReportTranasaction({
      this.status, 
      this.code, 
      this.message, 
      this.data,});

  ReportTranasaction.fromJson(dynamic json) {
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

/// total_transaction : 142
/// total_income_transaction : 12173720
/// total_product : 342
/// total_benefit : 11751000
/// products : [{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":56},{"PRODUCT_NAME":"produk423","PRODUCT_SOLD":52},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":52},{"PRODUCT_NAME":"produk 123","PRODUCT_SOLD":24},{"PRODUCT_NAME":"test123","PRODUCT_SOLD":20},{"PRODUCT_NAME":"xova","PRODUCT_SOLD":18},{"PRODUCT_NAME":"produk333","PRODUCT_SOLD":16},{"PRODUCT_NAME":"test123","PRODUCT_SOLD":11},{"PRODUCT_NAME":"produk423","PRODUCT_SOLD":8},{"PRODUCT_NAME":"Geprek","PRODUCT_SOLD":6},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":5},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":5},{"PRODUCT_NAME":"Mike GOreng","PRODUCT_SOLD":5},{"PRODUCT_NAME":"sdfsfsfs","PRODUCT_SOLD":4},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":2},{"PRODUCT_NAME":"Ayam Bakar mantan v.beta","PRODUCT_SOLD":1}]
/// payment_method : [{"payment_method":"Cash","total_transaction":70,"nominal_transaction":"7122300"},{"payment_method":"Link Aja","total_transaction":12,"nominal_transaction":"268500"},{"payment_method":"SHOPPE","total_transaction":1,"nominal_transaction":"50000"},{"payment_method":"TOKOPEDIA","total_transaction":2,"nominal_transaction":"62000"},{"payment_method":"GRAB-FOOD","total_transaction":2,"nominal_transaction":"24000"},{"payment_method":"BCA","total_transaction":2,"nominal_transaction":"100000"},{"payment_method":"DANA","total_transaction":7,"nominal_transaction":"743760"},{"payment_method":"QRIS","total_transaction":4,"nominal_transaction":"1148000"},{"payment_method":"GO-PAY","total_transaction":1,"nominal_transaction":"136500"}]

class DataReport {
  DataReport({
      this.totalTransaction, 
      this.totalIncomeTransaction, 
      this.totalProduct, 
      this.totalBenefit, 
      this.totalDiscount,
      this.products,
      this.paymentMethod,});

  DataReport.fromJson(dynamic json) {
    totalTransaction = json['total_transaction'];
    totalIncomeTransaction = json['total_income_transaction'];
    totalProduct = json['total_product'];
    totalBenefit = json['total_benefit'];
    totalDiscount = json['total_discount'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    if (json['payment_method'] != null) {
      paymentMethod = [];
      json['payment_method'].forEach((v) {
        paymentMethod?.add(Payment_method.fromJson(v));
      });
    }
  }
  int? totalTransaction;
  int? totalIncomeTransaction;
  int? totalProduct;
  int? totalBenefit;
  int? totalDiscount;
  List<Products>? products;
  List<Payment_method>? paymentMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_transaction'] = totalTransaction;
    map['total_income_transaction'] = totalIncomeTransaction;
    map['total_product'] = totalProduct;
    map['total_benefit'] = totalBenefit;
    map['total_discount'] = totalDiscount;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (paymentMethod != null) {
      map['payment_method'] = paymentMethod?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// payment_method : "Cash"
/// total_transaction : 70
/// nominal_transaction : "7122300"

class Payment_method {
  Payment_method({
      this.paymentMethod, 
      this.totalTransaction, 
      this.nominalTransaction,});

  Payment_method.fromJson(dynamic json) {
    paymentMethod = json['payment_method'];
    totalTransaction = json['total_transaction'];
    nominalTransaction = json['nominal_transaction'];
  }
  String? paymentMethod;
  int? totalTransaction;
  String? nominalTransaction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_method'] = paymentMethod;
    map['total_transaction'] = totalTransaction;
    map['nominal_transaction'] = nominalTransaction;
    return map;
  }

}

/// PRODUCT_NAME : "sdfsfsfs"
/// PRODUCT_SOLD : 56

class Products {
  Products({
      this.productname, 
      this.productsold,});

  Products.fromJson(dynamic json) {
    productname = json['PRODUCT_NAME'];
    productsold = json['PRODUCT_SOLD'];
  }
  String? productname;
  int? productsold;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PRODUCT_NAME'] = productname;
    map['PRODUCT_SOLD'] = productsold;
    return map;
  }

}