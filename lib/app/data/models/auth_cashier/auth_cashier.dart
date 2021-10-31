/// status : true
/// code : 201
/// message : "Login Success"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJsdW1lbi1qd3QiLCJzdWIiOiJmNDY3YThjMGNhYmI0ZWMyMDMyZGQ2N2EwMjYzYmEzNCIsImlhdCI6MTYzNTY1NTE5NH0._VRUD2qG-zDIHZiFz_87agcwwKXALibRb_0qk42PycU","detail_user":{"EMPLOYE_ID":"2dead4e5b6f2f9a2414ea6a319609e43","NAME":"Sofyan","PHONE_NUMBER":"0895444624006","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","deleted_at":null,"updated_at":"2021-10-05T16:18:04.000000Z","created_at":"2021-10-05T15:10:43.000000Z","ADDRESS":"ass","ROLE_ID":null,"role":null,"store":[{"STORE_ID":"c0a56056af1a65cadc2f250e3f2c4a3f","STORE_NAME":"cabang 2","STORE_DESCRIPTION":"xavxx","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-06T14:21:56.000000Z","deleted_at":null,"STORE_OPERATION_START":"19:13","STORE_OPERATION_CLOSE":"02:13","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}},{"STORE_ID":"9b6800204e9ccdd85a90c96dc37fae22","STORE_NAME":"caffe 4 5","STORE_DESCRIPTION":"vvcf","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-06T13:16:26.000000Z","deleted_at":null,"STORE_OPERATION_START":"05:17","STORE_OPERATION_CLOSE":"08:50","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}}]}}

class AuthCashier {
  AuthCashier({
      this.status, 
      this.code, 
      this.message, 
      this.data,});

  AuthCashier.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  int? code;
  String? message;
  Data? data;

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

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJsdW1lbi1qd3QiLCJzdWIiOiJmNDY3YThjMGNhYmI0ZWMyMDMyZGQ2N2EwMjYzYmEzNCIsImlhdCI6MTYzNTY1NTE5NH0._VRUD2qG-zDIHZiFz_87agcwwKXALibRb_0qk42PycU"
/// detail_user : {"EMPLOYE_ID":"2dead4e5b6f2f9a2414ea6a319609e43","NAME":"Sofyan","PHONE_NUMBER":"0895444624006","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","deleted_at":null,"updated_at":"2021-10-05T16:18:04.000000Z","created_at":"2021-10-05T15:10:43.000000Z","ADDRESS":"ass","ROLE_ID":null,"role":null,"store":[{"STORE_ID":"c0a56056af1a65cadc2f250e3f2c4a3f","STORE_NAME":"cabang 2","STORE_DESCRIPTION":"xavxx","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-06T14:21:56.000000Z","deleted_at":null,"STORE_OPERATION_START":"19:13","STORE_OPERATION_CLOSE":"02:13","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}},{"STORE_ID":"9b6800204e9ccdd85a90c96dc37fae22","STORE_NAME":"caffe 4 5","STORE_DESCRIPTION":"vvcf","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-06T13:16:26.000000Z","deleted_at":null,"STORE_OPERATION_START":"05:17","STORE_OPERATION_CLOSE":"08:50","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}}]}

class Data {
  Data({
      this.token, 
      this.detailUser,});

  Data.fromJson(dynamic json) {
    token = json['token'];
    detailUser = json['detail_user'] != null ? Detail_user.fromJson(json['detail_user']) : null;
  }
  String? token;
  Detail_user? detailUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (detailUser != null) {
      map['detail_user'] = detailUser?.toJson();
    }
    return map;
  }

}

/// EMPLOYE_ID : "2dead4e5b6f2f9a2414ea6a319609e43"
/// NAME : "Sofyan"
/// PHONE_NUMBER : "0895444624006"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// deleted_at : null
/// updated_at : "2021-10-05T16:18:04.000000Z"
/// created_at : "2021-10-05T15:10:43.000000Z"
/// ADDRESS : "ass"
/// ROLE_ID : null
/// role : null
/// store : [{"STORE_ID":"c0a56056af1a65cadc2f250e3f2c4a3f","STORE_NAME":"cabang 2","STORE_DESCRIPTION":"xavxx","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-06T14:21:56.000000Z","deleted_at":null,"STORE_OPERATION_START":"19:13","STORE_OPERATION_CLOSE":"02:13","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}},{"STORE_ID":"9b6800204e9ccdd85a90c96dc37fae22","STORE_NAME":"caffe 4 5","STORE_DESCRIPTION":"vvcf","ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-06T13:16:26.000000Z","deleted_at":null,"STORE_OPERATION_START":"05:17","STORE_OPERATION_CLOSE":"08:50","STORE_OPERATION_STATUS":"open","address":{"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null},"owner":{"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}}]

class Detail_user {
  Detail_user({
      this.employeid, 
      this.name, 
      this.phonenumber, 
      this.userid, 
      this.deletedAt, 
      this.updatedAt, 
      this.createdAt, 
      this.address, 
      this.roleid, 
      this.role, 
      this.store,});

  Detail_user.fromJson(dynamic json) {
    employeid = json['EMPLOYE_ID'];
    name = json['NAME'];
    phonenumber = json['PHONE_NUMBER'];
    userid = json['USER_ID'];
    deletedAt = json['deleted_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    address = json['ADDRESS'];
    roleid = json['ROLE_ID'];
    role = json['role'];
    if (json['store'] != null) {
      store = [];
      json['store'].forEach((v) {
        store?.add(Store.fromJson(v));
      });
    }
  }
  String? employeid;
  String? name;
  String? phonenumber;
  String? userid;
  dynamic deletedAt;
  String? updatedAt;
  String? createdAt;
  String? address;
  dynamic roleid;
  dynamic role;
  List<Store>? store;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['EMPLOYE_ID'] = employeid;
    map['NAME'] = name;
    map['PHONE_NUMBER'] = phonenumber;
    map['USER_ID'] = userid;
    map['deleted_at'] = deletedAt;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['ADDRESS'] = address;
    map['ROLE_ID'] = roleid;
    map['role'] = role;
    if (store != null) {
      map['store'] = store?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// STORE_ID : "c0a56056af1a65cadc2f250e3f2c4a3f"
/// STORE_NAME : "cabang 2"
/// STORE_DESCRIPTION : "xavxx"
/// ADDRESS_ID : "bb907c551ddc57fa8117b96c59b09bb8"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// created_at : "2021-10-06T14:21:56.000000Z"
/// updated_at : "2021-10-06T14:21:56.000000Z"
/// deleted_at : null
/// STORE_OPERATION_START : "19:13"
/// STORE_OPERATION_CLOSE : "02:13"
/// STORE_OPERATION_STATUS : "open"
/// address : {"ADDRESS_ID":"bb907c551ddc57fa8117b96c59b09bb8","ADDRESS_PROVINCE_ID":9,"ADDRESS_PROVINCE_NAME":"Jawa Barat","ADDRESS_CITY_ID":24,"ADDRESS_CITY_NAME":"Bandung Barat","ADDRESS_SUBDISTRICT_ID":369,"ADDRESS_SUBDISTRICT_NAME":"Cihampelas","ADDRESS_POSCODE":"425245","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","ADDRESS_NO_TELP":"-","ADDRESS_TYPE":"Kabupaten","ADDRESS_ALIAS":"ccscvc","created_at":"2021-10-06T14:21:56.000000Z","updated_at":"2021-10-28T12:43:12.000000Z","deleted_at":null}
/// owner : {"USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","USER_FULLNAME":"Diyanto v2","USER_UUID":null,"USER_VERSION_APP":null,"USER_OS_VERSION":null,"USER_STATUS":"1","USER_NO_HP":"085624277920","USER_EMAIL":"diyanto2911@gmail.com","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-10-26T12:54:24.000000Z","USER_PHOTO":null,"delete_at":null,"CREATED_BY":null,"ROLE_ID":"3","USER_USERNAME":"Diyanto35768373","USER_TYPE":null,"USER_GENDER":"Laki-Laki","EXPIRED_DATE":"2021-07-09","business":{"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}}

class Store {
  Store({
      this.storeid, 
      this.storename, 
      this.storedescription, 
      this.addressid, 
      this.userid, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.storeoperationstart, 
      this.storeoperationclose, 
      this.storeoperationstatus, 
      this.address, 
      this.owner,});

  Store.fromJson(dynamic json) {
    storeid = json['STORE_ID'];
    storename = json['STORE_NAME'];
    storedescription = json['STORE_DESCRIPTION'];
    addressid = json['ADDRESS_ID'];
    userid = json['USER_ID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    storeoperationstart = json['STORE_OPERATION_START'];
    storeoperationclose = json['STORE_OPERATION_CLOSE'];
    storeoperationstatus = json['STORE_OPERATION_STATUS'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }
  String? storeid;
  String? storename;
  String? storedescription;
  String? addressid;
  String? userid;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? storeoperationstart;
  String? storeoperationclose;
  String? storeoperationstatus;
  Address? address;
  Owner? owner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['STORE_ID'] = storeid;
    map['STORE_NAME'] = storename;
    map['STORE_DESCRIPTION'] = storedescription;
    map['ADDRESS_ID'] = addressid;
    map['USER_ID'] = userid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['STORE_OPERATION_START'] = storeoperationstart;
    map['STORE_OPERATION_CLOSE'] = storeoperationclose;
    map['STORE_OPERATION_STATUS'] = storeoperationstatus;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    return map;
  }

}

/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// USER_FULLNAME : "Diyanto v2"
/// USER_UUID : null
/// USER_VERSION_APP : null
/// USER_OS_VERSION : null
/// USER_STATUS : "1"
/// USER_NO_HP : "085624277920"
/// USER_EMAIL : "diyanto2911@gmail.com"
/// created_at : "2021-06-25T11:12:38.000000Z"
/// updated_at : "2021-10-26T12:54:24.000000Z"
/// USER_PHOTO : null
/// delete_at : null
/// CREATED_BY : null
/// ROLE_ID : "3"
/// USER_USERNAME : "Diyanto35768373"
/// USER_TYPE : null
/// USER_GENDER : "Laki-Laki"
/// EXPIRED_DATE : "2021-07-09"
/// business : {"BUSINESS_ID":"33fdedf8b9a0a3dc0dfb7a3c561ae2ed","BUSINESS_NAME":"Caffeine Test","BUSINESS_CATEGORY_ID":"10","BUSINESS_CREW_TOTAL":"Bekerja Sendiri","BUSINESS_BRANCH":"Hanya 1 Outlet","BUSINESS_WEBSITE_NAME":"Hallo","BUSINESS_CONTACT":"6285624277920","created_at":"2021-06-25T11:12:38.000000Z","updated_at":"2021-07-25T05:42:45.000000Z","USER_ID":"f467a8c0cabb4ec2032dd67a0263ba34","BUSINESS_LOGO":"http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"}

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
      this.expireddate, 
      this.business,});

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
    business = json['business'] != null ? Business.fromJson(json['business']) : null;
  }
  String? userid;
  String? userfullname;
  dynamic useruuid;
  dynamic userversionapp;
  dynamic userosversion;
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
  dynamic usertype;
  String? usergender;
  String? expireddate;
  Business? business;

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
    if (business != null) {
      map['business'] = business?.toJson();
    }
    return map;
  }

}

/// BUSINESS_ID : "33fdedf8b9a0a3dc0dfb7a3c561ae2ed"
/// BUSINESS_NAME : "Caffeine Test"
/// BUSINESS_CATEGORY_ID : "10"
/// BUSINESS_CREW_TOTAL : "Bekerja Sendiri"
/// BUSINESS_BRANCH : "Hanya 1 Outlet"
/// BUSINESS_WEBSITE_NAME : "Hallo"
/// BUSINESS_CONTACT : "6285624277920"
/// created_at : "2021-06-25T11:12:38.000000Z"
/// updated_at : "2021-07-25T05:42:45.000000Z"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// BUSINESS_LOGO : "http://apiddev.mudahkan.com/files/logo/business/4b7911da39b78cffa8bd1b9d5ab1dd18.jpg"

class Business {
  Business({
      this.businessid, 
      this.businessname, 
      this.businesscategoryid, 
      this.businesscrewtotal, 
      this.businessbranch, 
      this.businesswebsitename, 
      this.businesscontact, 
      this.createdAt, 
      this.updatedAt, 
      this.userid, 
      this.businesslogo,});

  Business.fromJson(dynamic json) {
    businessid = json['BUSINESS_ID'];
    businessname = json['BUSINESS_NAME'];
    businesscategoryid = json['BUSINESS_CATEGORY_ID'];
    businesscrewtotal = json['BUSINESS_CREW_TOTAL'];
    businessbranch = json['BUSINESS_BRANCH'];
    businesswebsitename = json['BUSINESS_WEBSITE_NAME'];
    businesscontact = json['BUSINESS_CONTACT'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userid = json['USER_ID'];
    businesslogo = json['BUSINESS_LOGO'];
  }
  String? businessid;
  String? businessname;
  String? businesscategoryid;
  String? businesscrewtotal;
  String? businessbranch;
  String? businesswebsitename;
  String? businesscontact;
  String? createdAt;
  String? updatedAt;
  String? userid;
  String? businesslogo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BUSINESS_ID'] = businessid;
    map['BUSINESS_NAME'] = businessname;
    map['BUSINESS_CATEGORY_ID'] = businesscategoryid;
    map['BUSINESS_CREW_TOTAL'] = businesscrewtotal;
    map['BUSINESS_BRANCH'] = businessbranch;
    map['BUSINESS_WEBSITE_NAME'] = businesswebsitename;
    map['BUSINESS_CONTACT'] = businesscontact;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['USER_ID'] = userid;
    map['BUSINESS_LOGO'] = businesslogo;
    return map;
  }

}

/// ADDRESS_ID : "bb907c551ddc57fa8117b96c59b09bb8"
/// ADDRESS_PROVINCE_ID : 9
/// ADDRESS_PROVINCE_NAME : "Jawa Barat"
/// ADDRESS_CITY_ID : 24
/// ADDRESS_CITY_NAME : "Bandung Barat"
/// ADDRESS_SUBDISTRICT_ID : 369
/// ADDRESS_SUBDISTRICT_NAME : "Cihampelas"
/// ADDRESS_POSCODE : "425245"
/// USER_ID : "f467a8c0cabb4ec2032dd67a0263ba34"
/// ADDRESS_NO_TELP : "-"
/// ADDRESS_TYPE : "Kabupaten"
/// ADDRESS_ALIAS : "ccscvc"
/// created_at : "2021-10-06T14:21:56.000000Z"
/// updated_at : "2021-10-28T12:43:12.000000Z"
/// deleted_at : null

class Address {
  Address({
      this.addressid, 
      this.addressprovinceid, 
      this.addressprovincename, 
      this.addresscityid, 
      this.addresscityname, 
      this.addresssubdistrictid, 
      this.addresssubdistrictname, 
      this.addressposcode, 
      this.userid, 
      this.addressnotelp, 
      this.addresstype, 
      this.addressalias, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Address.fromJson(dynamic json) {
    addressid = json['ADDRESS_ID'];
    addressprovinceid = json['ADDRESS_PROVINCE_ID'];
    addressprovincename = json['ADDRESS_PROVINCE_NAME'];
    addresscityid = json['ADDRESS_CITY_ID'];
    addresscityname = json['ADDRESS_CITY_NAME'];
    addresssubdistrictid = json['ADDRESS_SUBDISTRICT_ID'];
    addresssubdistrictname = json['ADDRESS_SUBDISTRICT_NAME'];
    addressposcode = json['ADDRESS_POSCODE'];
    userid = json['USER_ID'];
    addressnotelp = json['ADDRESS_NO_TELP'];
    addresstype = json['ADDRESS_TYPE'];
    addressalias = json['ADDRESS_ALIAS'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  String? addressid;
  int? addressprovinceid;
  String? addressprovincename;
  int? addresscityid;
  String? addresscityname;
  int? addresssubdistrictid;
  String? addresssubdistrictname;
  String? addressposcode;
  String? userid;
  String? addressnotelp;
  String? addresstype;
  String? addressalias;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ADDRESS_ID'] = addressid;
    map['ADDRESS_PROVINCE_ID'] = addressprovinceid;
    map['ADDRESS_PROVINCE_NAME'] = addressprovincename;
    map['ADDRESS_CITY_ID'] = addresscityid;
    map['ADDRESS_CITY_NAME'] = addresscityname;
    map['ADDRESS_SUBDISTRICT_ID'] = addresssubdistrictid;
    map['ADDRESS_SUBDISTRICT_NAME'] = addresssubdistrictname;
    map['ADDRESS_POSCODE'] = addressposcode;
    map['USER_ID'] = userid;
    map['ADDRESS_NO_TELP'] = addressnotelp;
    map['ADDRESS_TYPE'] = addresstype;
    map['ADDRESS_ALIAS'] = addressalias;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}