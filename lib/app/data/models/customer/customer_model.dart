/// status : true
/// code : 200
/// message : "Get data success!"
/// total_data : 1
/// data : [{"CUSTOMER_PARTNER_ID":"46f78b26b5744895bb074b76df3db605","CUSTOMER_PARTNER_NAME":"diyanto2","CUSTOMER_PARTNER_NUMBER":"09876665","CUSTOMER_PARTNER_EMAIL":"diyanto2911@gmail.com","CUSTOMER_PARTNER_ADDRESS":"sukasari","created_at":"2021-09-25T15:30:29.000000Z","updated_at":"2021-09-25T15:30:29.000000Z","deleted_at":null,"OWNER_ID":"f467a8c0cabb4ec2032dd67a0263ba34"}]

class CustomerModel {
  CustomerModel({
      this.status, 
      this.code, 
      this.message, 
      this.totalData, 
      this.data,});

  CustomerModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalData = json['total_data'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataCustomer.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? message;
  int? totalData;
  List<DataCustomer>? data;

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

/// CUSTOMER_PARTNER_ID : "46f78b26b5744895bb074b76df3db605"
/// CUSTOMER_PARTNER_NAME : "diyanto2"
/// CUSTOMER_PARTNER_NUMBER : "09876665"
/// CUSTOMER_PARTNER_EMAIL : "diyanto2911@gmail.com"
/// CUSTOMER_PARTNER_ADDRESS : "sukasari"
/// created_at : "2021-09-25T15:30:29.000000Z"
/// updated_at : "2021-09-25T15:30:29.000000Z"
/// deleted_at : null
/// OWNER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"

class DataCustomer {
  DataCustomer({
      this.customerpartnerid, 
      this.customerpartnername, 
      this.customerpartnernumber, 
      this.customerpartneremail, 
      this.customerpartneraddress, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.ownerid,});

  DataCustomer.fromJson(dynamic json) {
    customerpartnerid = json['CUSTOMER_PARTNER_ID'];
    customerpartnername = json['CUSTOMER_PARTNER_NAME'];
    customerpartnernumber = json['CUSTOMER_PARTNER_NUMBER'];
    customerpartneremail = json['CUSTOMER_PARTNER_EMAIL'];
    customerpartneraddress = json['CUSTOMER_PARTNER_ADDRESS'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    ownerid = json['OWNER_ID'];
  }
  String? customerpartnerid;
  String? customerpartnername;
  String? customerpartnernumber;
  String? customerpartneremail;
  String? customerpartneraddress;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? ownerid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CUSTOMER_PARTNER_ID'] = customerpartnerid;
    map['CUSTOMER_PARTNER_NAME'] = customerpartnername;
    map['CUSTOMER_PARTNER_NUMBER'] = customerpartnernumber;
    map['CUSTOMER_PARTNER_EMAIL'] = customerpartneremail;
    map['CUSTOMER_PARTNER_ADDRESS'] = customerpartneraddress;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['OWNER_ID'] = ownerid;
    return map;
  }

}