/// status : true
/// code : 200
/// message : "Get Data Success!"
/// data : [{"name":"Ice Gula Aren","category":"Iced Coffee","count":13,"sum":169000},{"name":"Americano","category":"Iced Coffee","count":7,"sum":70000},{"name":"Ice Coffee milk","category":"Iced Coffee","count":4,"sum":28000},{"name":"Ice Caramel Latte","category":"Iced Coffee","count":4,"sum":52000},{"name":"Ice Hazelnut Latte","category":"Iced Coffee","count":4,"sum":52000},{"name":"Ice Spanish Latte","category":"Iced Coffee","count":4,"sum":52000},{"name":"Iced Vanilla Latte","category":"Iced Coffee","count":2,"sum":26000},{"name":"Ice Amercano","category":"Iced Coffee","count":2,"sum":20000},{"name":"Coffe Spanish","category":"Iced Coffee","count":2,"sum":26000}]

class ReportTransactionByCategory {
  ReportTransactionByCategory({
      this.status, 
      this.code, 
      this.message, 
      this.data,});

  ReportTransactionByCategory.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null || json['data']!=[]) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Ice Gula Aren"
/// category : "Iced Coffee"
/// count : 13
/// sum : 169000

class Data {
  Data({
      this.name, 
      this.category, 
      this.count, 
      this.sum,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    category = json['category'];
    count = json['count'];
    sum = json['sum'];
  }
  String? name;
  String? category;
  int? count;
  int? sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['category'] = category;
    map['count'] = count;
    map['sum'] = sum;
    return map;
  }

}