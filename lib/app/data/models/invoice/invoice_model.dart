/// status : true
/// code : 200
/// message : "Get data success!"
/// total_data : 1
/// data : [{"STRUK_ID":"8f93ea01cce74c2ba87959cabd839b81","FOOTER_TEXT":"Teirmakasih sudah berbelanja","CETAK_LOGO_STRUK":true,"CETAK_LOGO_DPOS":true,"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-09-30T15:54:47.000000Z","updated_at":"2021-09-30T15:54:47.000000Z","deleted_at":null}]

class InvoiceModel {
  InvoiceModel({
      this.status, 
      this.code, 
      this.message, 
      this.totalData, 
      this.data,});

  InvoiceModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalData = json['total_data'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? message;
  int? totalData;
  List<Data>? data;

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

/// STRUK_ID : "8f93ea01cce74c2ba87959cabd839b81"
/// FOOTER_TEXT : "Teirmakasih sudah berbelanja"
/// CETAK_LOGO_STRUK : true
/// CETAK_LOGO_DPOS : true
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// created_at : "2021-09-30T15:54:47.000000Z"
/// updated_at : "2021-09-30T15:54:47.000000Z"
/// deleted_at : null

class Data {
  Data({
      this.strukid, 
      this.footertext, 
      this.cetaklogostruk, 
      this.cetaklogodpos, 
      this.userid, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Data.fromJson(dynamic json) {
    strukid = json['STRUK_ID'];
    footertext = json['FOOTER_TEXT'];
    cetaklogostruk = json['CETAK_LOGO_STRUK'];
    cetaklogodpos = json['CETAK_LOGO_DPOS'];
    userid = json['USER_ID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  String? strukid;
  String? footertext;
  bool? cetaklogostruk;
  bool? cetaklogodpos;
  String? userid;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STRUK_ID'] = strukid;
    map['FOOTER_TEXT'] = footertext;
    map['CETAK_LOGO_STRUK'] = cetaklogostruk;
    map['CETAK_LOGO_DPOS'] = cetaklogodpos;
    map['USER_ID'] = userid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}