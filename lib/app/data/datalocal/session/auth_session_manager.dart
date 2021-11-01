import 'package:get_storage/get_storage.dart';
import 'package:warmi/core/globals/global_string.dart';

class AuthSessionManager {
  static String? _userId;
  static String? _userFullName;
  static String? _userNoHp;
  static String? _userEmail;
  static String? _userPhoto;
  static String? _roleId;
  static String? _roleName;
  static String? _statusCodeID;
  static String? _statusName;
  static String? _expiredDate;
  static String? _storeId;
  static String? _storeName;
  static String? _businessId;
  static String? _businessName;
  static int? _storeCount;
  static String? _userIdOwner;
  static String? _categoryBusinessId;
  static String? _categoryBusinessName;
  static String? _token;
  static String? _businessLogo;

  AuthSessionManager() {
    getSessionFromLocal();
  }

  void getSessionFromLocal() {
    GetStorage box = GetStorage();
    userId = box.read(MyString.USER_ID);
    userFullName = box.read(MyString.USER_FULLNAME);
    userNoHp = box.read(MyString.USER_NO_HP);
    userEmail = box.read(MyString.USER_EMAIL);
    roleId = box.read(MyString.ROLE_ID);
    roleName = box.read(MyString.ROLE_NAME);
    if(box.hasData(MyString.STATUS_CODE_ID)){
    statusCodeID = box.read(MyString.STATUS_CODE_ID);
    }

    if(box.hasData(MyString.STATUS_NAME)){
      statusName = box.read(MyString.STATUS_NAME);
    }
    if(box.hasData(MyString.EXPIRED_DATE)){
      expiredDate = box.read(MyString.EXPIRED_DATE);
    }
    if(box.hasData(MyString.STORE_ID)){
      storeId = box.read(MyString.STORE_ID);
      storeName = box.read(MyString.STORE_NAME);
    }




    businessId = box.read(MyString.BUSINESS_ID);
    businessName = box.read(MyString.BUSINESS_NAME);
    storeCount = box.read(MyString.STORE_COUNT);
    categoryBusinessId = box.read(MyString.BUSINESS_CATEGORY_ID);
    categoryBusinessName = box.read(MyString.BUSINESS_CATEGORY_NAME);
    if(box.hasData(MyString.BUSINESS_LOGO)){
      businessLogo = box.read(MyString.BUSINESS_LOGO);
    }
    userIdOwner = box.read(MyString.USER_ID_OWNER);
    token = box.read('token');
  }

  String get token => _token!;

  set token(String value) {
    _token = value;
  }

  String get userId => _userId!;

  set userId(String value) {
    _userId = value;
  }

  String get userFullName => _userFullName!;

  set userFullName(String value) {
    _userFullName = value;
  }

  String get categoryBusinessName => _categoryBusinessName!;

  set categoryBusinessName(String value) {
    _categoryBusinessName = value;
  }

  String get categoryBusinessId => _categoryBusinessId!;

  set categoryBusinessId(String value) {
    _categoryBusinessId = value;
  }

  String get userIdOwner => _userIdOwner!;

  set userIdOwner(String value) {
    _userIdOwner = value;
  }

  int get storeCount => _storeCount!;

  set storeCount(int value) {
    _storeCount = value;
  }

  String get businessName => _businessName!;

  set businessName(String value) {
    _businessName = value;
  }

  String get businessId => _businessId!;

  set businessId(String value) {
    _businessId = value;
  }

  String get storeName => _storeName!;

  set storeName(String value) {
    _storeName = value;
  }

  String get storeId => _storeId!;

  set storeId(String value) {
    _storeId = value;
  }

  String get expiredDate => _expiredDate!;

  set expiredDate(String value) {
    _expiredDate = value;
  }

  String get statusName => _statusName!;

  set statusName(String value) {
    _statusName = value;
  }

  String get statusCodeID => _statusCodeID!;

  set statusCodeID(String value) {
    _statusCodeID = value;
  }

  String get roleName => _roleName!;

  set roleName(String value) {
    _roleName = value;
  }

  String get roleId => _roleId!;

  set roleId(String value) {
    _roleId = value;
  }

  String get userPhoto => _userPhoto!;

  set userPhoto(String value) {
    _userPhoto = value;
  }

  String get userEmail => _userEmail!;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get userNoHp => _userNoHp!;

  set userNoHp(String value) {
    _userNoHp = value;
  }

   String get businessLogo => _businessLogo!;

   set businessLogo(String value) {
    _businessLogo = value;
  }
}
