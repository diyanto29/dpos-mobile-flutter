/// status : true
/// code : 200
/// message : "Get data success!"
/// total_data : 2
/// data : [{"PRINTER_ID":"6eed12fdb16f4c598cffa24f3cd53755","PRINTER_NAME":"EPSON555","PRINTER_PAPER_TYPE":"58","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-10-04T13:03:25.000000Z","updated_at":"2021-10-04T13:03:25.000000Z","deleted_at":null,"PRINTER_MAC":"232323","PRINTER_IP":null,"PRINTER_PORT":null},{"PRINTER_ID":"e8e995d4d1b7463e9e8ccdbaeab982ed","PRINTER_NAME":"EPSON","PRINTER_PAPER_TYPE":"58","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-09-30T15:51:36.000000Z","updated_at":"2021-09-30T15:51:36.000000Z","deleted_at":null,"PRINTER_MAC":"232323","PRINTER_IP":null,"PRINTER_PORT":null}]

class PrinterModel {
  PrinterModel({
      this.status, 
      this.code, 
      this.message, 
      this.totalData, 
      this.data,});

  PrinterModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalData = json['total_data'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PrinterData.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? message;
  int? totalData;
  List<PrinterData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    map['total_data'] = totalData;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// PRINTER_ID : "6eed12fdb16f4c598cffa24f3cd53755"
/// PRINTER_NAME : "EPSON555"
/// PRINTER_PAPER_TYPE : "58"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// created_at : "2021-10-04T13:03:25.000000Z"
/// updated_at : "2021-10-04T13:03:25.000000Z"
/// deleted_at : null
/// PRINTER_MAC : "232323"
/// PRINTER_IP : null
/// PRINTER_PORT : null

class PrinterData {
  PrinterData({
      this.printerid, 
      this.printername, 
      this.printerpapertype, 
      this.userid, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.printermac, 
      this.printerip, 
      this.printerport,});

  PrinterData.fromJson(dynamic json) {
    printerid = json['PRINTER_ID'];
    printername = json['PRINTER_NAME'];
    printerpapertype = json['PRINTER_PAPER_TYPE'];
    userid = json['USER_ID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    printermac = json['PRINTER_MAC'];
    printerip = json['PRINTER_IP'];
    printerport = json['PRINTER_PORT'];
  }
  String? printerid;
  String? printername;
  String? printerpapertype;
  String? userid;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? printermac;
  dynamic printerip;
  dynamic printerport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PRINTER_ID'] = printerid;
    map['PRINTER_NAME'] = printername;
    map['PRINTER_PAPER_TYPE'] = printerpapertype;
    map['USER_ID'] = userid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['PRINTER_MAC'] = printermac;
    map['PRINTER_IP'] = printerip;
    map['PRINTER_PORT'] = printerport;
    return map;
  }

}