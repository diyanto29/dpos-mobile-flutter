/// status : true
/// code : 200
/// message : "Get data success!"
/// total_data : 1
/// data : {"TAX_SERVICE_ID":"f8ebcf827f0342ab80bf4566eca9dfc1","TAX_PERCENTAGE":10,"TAX_TYPE":"percent","TAX_STATUS":"1","STORE_ID":null,"created_at":"2021-11-14T17:00:00.000000Z","updated_at":"2021-11-14T17:00:00.000000Z","deleted_at":null,"SERVICE_PERCENTAGE":15,"SERVICE_TYPE":"percent","SERVICE_STATUS":"1","INCLUDE_COUNT_TAX_SERVICE":"1","USER_ID":"062ce2e6521814b52148a211f13631f3"}

class ModelTaxService {
  ModelTaxService({
      this.status, 
      this.code, 
      this.message, 
      this.totalData, 
      this.data,});

  ModelTaxService.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalData = json['total_data'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  int? code;
  String? message;
  int? totalData;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    map['total_data'] = totalData;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// TAX_SERVICE_ID : "f8ebcf827f0342ab80bf4566eca9dfc1"
/// TAX_PERCENTAGE : 10
/// TAX_TYPE : "percent"
/// TAX_STATUS : "1"
/// STORE_ID : null
/// created_at : "2021-11-14T17:00:00.000000Z"
/// updated_at : "2021-11-14T17:00:00.000000Z"
/// deleted_at : null
/// SERVICE_PERCENTAGE : 15
/// SERVICE_TYPE : "percent"
/// SERVICE_STATUS : "1"
/// INCLUDE_COUNT_TAX_SERVICE : "1"
/// USER_ID : "062ce2e6521814b52148a211f13631f3"

class Data {
  Data({
      this.taxserviceid, 
      this.taxpercentage, 
      this.taxtype, 
      this.taxstatus, 
      this.storeid, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.servicepercentage, 
      this.servicetype, 
      this.servicestatus, 
      this.includecounttaxservice, 
      this.userid,});

  Data.fromJson(dynamic json) {
    taxserviceid = json['TAX_SERVICE_ID'];
    taxpercentage = json['TAX_PERCENTAGE'];
    taxtype = json['TAX_TYPE'];
    taxstatus = json['TAX_STATUS'];
    storeid = json['STORE_ID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    servicepercentage = json['SERVICE_PERCENTAGE'];
    servicetype = json['SERVICE_TYPE'];
    servicestatus = json['SERVICE_STATUS'];
    includecounttaxservice = json['INCLUDE_COUNT_TAX_SERVICE'];
    userid = json['USER_ID'];
  }
  String? taxserviceid;
  int? taxpercentage;
  String? taxtype;
  String? taxstatus;
  dynamic storeid;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? servicepercentage;
  String? servicetype;
  String? servicestatus;
  String? includecounttaxservice;
  String? userid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TAX_SERVICE_ID'] = taxserviceid;
    map['TAX_PERCENTAGE'] = taxpercentage;
    map['TAX_TYPE'] = taxtype;
    map['TAX_STATUS'] = taxstatus;
    map['STORE_ID'] = storeid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['SERVICE_PERCENTAGE'] = servicepercentage;
    map['SERVICE_TYPE'] = servicetype;
    map['SERVICE_STATUS'] = servicestatus;
    map['INCLUDE_COUNT_TAX_SERVICE'] = includecounttaxservice;
    map['USER_ID'] = userid;
    return map;
  }

}