/// status : true
/// code : 200
/// message : "Get Data Success!"
/// data : [{"EMPLOYE_ID":"2dead4e5b6f2f9a2414ea6a319609e43","NAME":"Sofyan","PHONE_NUMBER":"0895444624007","PIN":"$2y$10$oHNRLpbcsWV8pyFeCHRt2.PJMD0cosblUHCZCcPa2aQtHXn0jmmAK","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","deleted_at":null,"updated_at":"2021-10-05T15:10:43.000000Z","created_at":"2021-10-05T15:10:43.000000Z","ADDRESS":null,"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto","USER_UUID":" ","USER_VERSION_APP":"","USER_OS_VERSION":"","USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-06-25T11:12:38.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768372","USER_TYPE":"4","USER_GENDER":"null","EXPIRED_DATE":"2021-07-09"}}]

class EmployesModel {
  EmployesModel({
      this.status, 
      this.code, 
      this.message, 
      this.data,});

  EmployesModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(EmployeData.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? message;
  List<EmployeData>? data;

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

/// EMPLOYE_ID : "2dead4e5b6f2f9a2414ea6a319609e43"
/// NAME : "Sofyan"
/// PHONE_NUMBER : "0895444624007"
/// PIN : "$2y$10$oHNRLpbcsWV8pyFeCHRt2.PJMD0cosblUHCZCcPa2aQtHXn0jmmAK"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// deleted_at : null
/// updated_at : "2021-10-05T15:10:43.000000Z"
/// created_at : "2021-10-05T15:10:43.000000Z"
/// ADDRESS : null
/// owner : {"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto","USER_UUID":" ","USER_VERSION_APP":"","USER_OS_VERSION":"","USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-06-25T11:12:38.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768372","USER_TYPE":"4","USER_GENDER":"null","EXPIRED_DATE":"2021-07-09"}

class EmployeData {
  EmployeData({
      this.employeid, 
      this.name, 
      this.phonenumber, 
      this.pin, 
      this.userid, 
      this.deletedAt, 
      this.updatedAt, 
      this.createdAt, 
      this.address, 
      this.owner,});

  EmployeData.fromJson(dynamic json) {
    employeid = json['EMPLOYE_ID'];
    name = json['NAME'];
    phonenumber = json['PHONE_NUMBER'];
    pin = json['PIN'];
    userid = json['USER_ID'];
    deletedAt = json['deleted_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    address = json['ADDRESS'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }
  String? employeid;
  String? name;
  String? phonenumber;
  String? pin;
  String? userid;
  dynamic deletedAt;
  String? updatedAt;
  String? createdAt;
  dynamic address;
  Owner? owner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EMPLOYE_ID'] = employeid;
    map['NAME'] = name;
    map['PHONE_NUMBER'] = phonenumber;
    map['PIN'] = pin;
    map['USER_ID'] = userid;
    map['deleted_at'] = deletedAt;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['ADDRESS'] = address;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    return map;
  }

}

/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// USER_FULLNAME : "Diyanto"
/// USER_UUID : " "
/// USER_VERSION_APP : ""
/// USER_OS_VERSION : ""
/// USER_STATUS : "1"
/// USER_NO_HP : "085624277920"
/// USER_EMAIL : "diyanto2911@gmail.com"
/// created_at : "2021-06-25T11:12:38.000000Z"
/// updated_at : "2021-06-25T11:12:38.000000Z"
/// USER_PHOTO : null
/// delete_at : null
/// CREATED_BY : null
/// ROLE_ID : "3"
/// USER_USERNAME : "Diyanto35768372"
/// USER_TYPE : "4"
/// USER_GENDER : "null"
/// EXPIRED_DATE : "2021-07-09"

class Owner {
  Owner({
      this.userid, 
      this.userfullname, 
      this.useruuid, 
      this.userversionapp, 
      this.userosversion, 
      this.userstatus, 
      this.usernohp, 
      this.useremail, 
      this.createdAt, 
      this.updatedAt, 
      this.userphoto, 
      this.deleteAt, 
      this.createdby, 
      this.roleid, 
      this.userusername, 
      this.usertype, 
      this.usergender, 
      this.expireddate,});

  Owner.fromJson(dynamic json) {
    userid = json['USER_ID'];
    userfullname = json['USER_FULLNAME'];
    useruuid = json['USER_UUID'];
    userversionapp = json['USER_VERSION_APP'];
    userosversion = json['USER_OS_VERSION'];
    userstatus = json['USER_STATUS'];
    usernohp = json['USER_NO_HP'];
    useremail = json['USER_EMAIL'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userphoto = json['USER_PHOTO'];
    deleteAt = json['delete_at'];
    createdby = json['CREATED_BY'];
    roleid = json['ROLE_ID'];
    userusername = json['USER_USERNAME'];
    usertype = json['USER_TYPE'];
    usergender = json['USER_GENDER'];
    expireddate = json['EXPIRED_DATE'];
  }
  String? userid;
  String? userfullname;
  String? useruuid;
  String? userversionapp;
  String? userosversion;
  String? userstatus;
  String? usernohp;
  String? useremail;
  String? createdAt;
  String? updatedAt;
  dynamic userphoto;
  dynamic deleteAt;
  dynamic createdby;
  String? roleid;
  String? userusername;
  String? usertype;
  String? usergender;
  String? expireddate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['USER_ID'] = userid;
    map['USER_FULLNAME'] = userfullname;
    map['USER_UUID'] = useruuid;
    map['USER_VERSION_APP'] = userversionapp;
    map['USER_OS_VERSION'] = userosversion;
    map['USER_STATUS'] = userstatus;
    map['USER_NO_HP'] = usernohp;
    map['USER_EMAIL'] = useremail;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['USER_PHOTO'] = userphoto;
    map['delete_at'] = deleteAt;
    map['CREATED_BY'] = createdby;
    map['ROLE_ID'] = roleid;
    map['USER_USERNAME'] = userusername;
    map['USER_TYPE'] = usertype;
    map['USER_GENDER'] = usergender;
    map['EXPIRED_DATE'] = expireddate;
    return map;
  }

}