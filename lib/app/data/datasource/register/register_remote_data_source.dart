import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/utils/enum.dart';

class RegisterRemoteDataSource extends BaseDio{



  Future<bool> register({String? username,String? password,Province? province,City? city,
  Subdistrict? subdistrict,String? postalCode,
  String? addressDetail,String? phoneNumber,String? fullName,String? email,String? businessName,TypeBusiness? business}) async {
    GetStorage box=GetStorage();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    var model=androidInfo.model;
    var os=androidInfo.version.baseOS;
    var uuid=androidInfo.androidId;
    try{
      Map<String, dynamic> data = {
        "address_province_id": province==null ? "":province.provinceId,
        "address_province_name": province==null ? "":province.province,
        "address_city_id": city==null ? "":city.cityId,
        "address_city_name":city==null ? "": city.cityName,
        "address_subdistrict_id": subdistrict==null ? "":subdistrict.subdistrictId,
        "address_subdistrict_name":subdistrict==null ? "": subdistrict.subdistrictName,
        "address_poscode": postalCode,
        "address_detail": addressDetail,
        "address_no_telp": phoneNumber,
        "address_type": city==null ? "":city.type,
        "address_alias": addressDetail,
        "user_fullname": fullName,
        "gender": "null",
        "user_password": password,
        "user_no_hp": phoneNumber,
        "user_email": email,
        "user_type": "4",
        "user_uuid": uuid,
        "user_token_firebase": "",
        "user_version_app": version,
        "user_os_version": os,
        "business_name": businessName,
        "business_category_id": business!.businessCategoryId
      };

       response=await dio.post("${MyString.registerUser}",data: jsonEncode(data));
      print(response!.data);
      if(response!.data['status']==null){
        Get.back();
        showSnackBar(snackBarType: SnackBarType.ERROR,title: "Login",message:
        response!.data['error']+" Sudah Digunakan");
        return false;
      }
      if(response!.data['status']){
        var data = response!.data['data'];
        var dataDetailUser = response!.data['data']['detail_user'];
        box.write("token", data['token']);

        //session detail user
        box.write(MyString.USER_ID, dataDetailUser['USER_ID']);
        box.write(MyString.USER_FULLNAME, dataDetailUser['USER_FULLNAME']);
        box.write(MyString.USER_NO_HP, dataDetailUser['USER_NO_HP']);
        box.write(MyString.USER_EMAIL, dataDetailUser['USER_EMAIL']);
        box.write(MyString.USER_USERNAME, dataDetailUser['USER_USERNAME']);
        box.write(MyString.USER_PHOTO, dataDetailUser['USER_PHOTO']);
        box.write(MyString.STORE_COUNT, dataDetailUser['store_count']);

        //session role user
        box.write(MyString.ROLE_ID, dataDetailUser['role']['ROLE_ID']);
        box.write(MyString.ROLE_NAME, dataDetailUser['role']['ROLE_NAME']);

        //checking id owner
        box.write(MyString.USER_ID_OWNER, dataDetailUser['USER_ID']);



        //user type account
        if(dataDetailUser['user_type']!=null){
          box.write(MyString.STATUS_CODE_ID, dataDetailUser['user_type']['STATUS_CODE_ID'].toString());
          box.write(MyString.STATUS_NAME, dataDetailUser['user_type']['STATUS_NAME']);
          box.write(MyString.EXPIRED_DATE, dataDetailUser['EXPIRED_DATE']);
        }

        //sessiojn store
        box.write(MyString.STORE_ID, dataDetailUser['store'][0]['STORE_ID'].toString());
        box.write(MyString.STORE_NAME, dataDetailUser['store'][0]['STORE_NAME']);

        //session bussines
        box.write(MyString.BUSINESS_ID, dataDetailUser['business']['BUSINESS_ID'].toString());
        box.write(MyString.BUSINESS_NAME, dataDetailUser['business']['BUSINESS_NAME']);
        box.write(MyString.BUSINESS_CATEGORY_ID, dataDetailUser['business']['BUSINESS_CATEGORY_ID'].toString());
        box.write(MyString.BUSINESS_CATEGORY_NAME,dataDetailUser['business']['category']['BUSINESS_CATEGORY_NAME']);
        box.write(MyString.BUSINESS_CREW_TOTAL,dataDetailUser['business']['BUSINESS_CREW_TOTAL']);
        box.write(MyString.BUSINESS_BRANCH, dataDetailUser['business']['BUSINESS_BRANCH']);
        box.write(MyString.BUSINESS_WEBSITE_ID, dataDetailUser['business']['BUSINESS_WEBSITE_ID']).toString();
        box.write(MyString.BUSINESS_CONTACT,dataDetailUser['business']['BUSINESS_CONTACT']);

        Get.offAllNamed(Routes.NAVIGATION);

        showSnackBar(snackBarType: SnackBarType.SUCCESS,title: "Register",message:  'Selamat Datang '+dataDetailUser['USER_FULLNAME']);

        return true;
      }else{
        Get.back();
        showSnackBar(snackBarType: SnackBarType.ERROR,title: "Login",message: response!.data['message']);
        return false;
      }


    }on DioError catch(e){
      print(e);
      showSnackBar(snackBarType: SnackBarType.ERROR, title: "Login",
          message:"Erorr Dari Api");
      return false;

    }
  }
}