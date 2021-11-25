import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/models/auth_cashier/auth_cashier.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/errors/exceptions.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/network/base_dio.dart';
import 'package:warmi/core/network/response_message.dart';
import 'package:warmi/core/utils/enum.dart';

class AuthRemoteDataSource extends BaseDio {
  Options? options;

  Future<bool> loginAuth({String? username, String? password}) async {
    GetStorage box = GetStorage();
    print("a");
    try {
      Map<String, dynamic> data = {
        "username": username,
        "user_password": password,
      };

      Response response =
          await dio.post("${MyString.login}", data: jsonEncode(data));
      print(response.data);
      if (response.data['status']) {
        var data = response.data['data'];
        var dataDetailUser = response.data['data']['detail_user'];
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
        if (dataDetailUser['user_type'] != null) {
          box.write(MyString.STATUS_CODE_ID,
              dataDetailUser['user_type']['STATUS_CODE_ID'].toString());
          box.write(
              MyString.STATUS_NAME, dataDetailUser['user_type']['STATUS_NAME']);
          box.write(MyString.EXPIRED_DATE, dataDetailUser['EXPIRED_DATE']);
        }

        //sessiojn store
        box.write(MyString.STORE_ID,
            dataDetailUser['store'][0]['STORE_ID'].toString());
        box.write(
            MyString.STORE_NAME, dataDetailUser['store'][0]['STORE_NAME']);
        if (dataDetailUser['store'][0]['address'] != null) {
          var dataAddress = dataDetailUser['store'][0]['address'];
          var address =
              "Kec. ${dataAddress['ADDRESS_SUBDISTRICT_NAME']} ${dataAddress['ADDRESS_TYPE']}. "
              "${dataAddress['ADDRESS_CITY_NAME']} - "
              "${dataAddress['ADDRESS_PROVINCE_NAME']}";
          box.write(MyString.STORE_ADDRESS, address);
        } else {
          box.write(MyString.STORE_ADDRESS, "-");
        }

        _downloadFile(dataDetailUser['business']['BUSINESS_LOGO'], 'logo')
            .then((value) {
          print(value.path);
        });

        //session bussines
        box.write(MyString.BUSINESS_ID,
            dataDetailUser['business']['BUSINESS_ID'].toString());
        box.write(MyString.BUSINESS_NAME,
            dataDetailUser['business']['BUSINESS_NAME']);
        box.write(MyString.BUSINESS_CATEGORY_ID,
            dataDetailUser['business']['BUSINESS_CATEGORY_ID'].toString());
        box.write(MyString.BUSINESS_CATEGORY_NAME,
            dataDetailUser['business']['category']['BUSINESS_CATEGORY_NAME']);
        box.write(MyString.BUSINESS_CREW_TOTAL,
            dataDetailUser['business']['BUSINESS_CREW_TOTAL']);
        box.write(MyString.BUSINESS_BRANCH,
            dataDetailUser['business']['BUSINESS_BRANCH']);
        box
            .write(MyString.BUSINESS_WEBSITE_ID,
                dataDetailUser['business']['BUSINESS_WEBSITE_ID'])
            .toString();
        box.write(MyString.BUSINESS_CONTACT,
            dataDetailUser['business']['BUSINESS_CONTACT']);

        Get.offAllNamed(Routes.NAVIGATION);

        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            title: "Login",
            message: 'Selamat Datang ' + dataDetailUser['USER_FULLNAME']);

        return true;
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: "Login",
            message: response.data['message']);
        return false;
      }
    } on DioError catch (e) {
      print(e);
      showSnackBar(
          snackBarType: SnackBarType.ERROR,
          title: "Login",
          message: "Username atau password salah");
      return false;
    }
  }

  Future<ResponseMessage> loginAuthCashier(
      {String? username, String? password}) async {
    GetStorage box = GetStorage();
    print("a");
    try {
      Map<String, dynamic> data = {
        "phone_number": username,
        "pin": password,
      };

      Response response =
          await dio.post("${MyString.loginCashier}", data: jsonEncode(data));

      if (response.data['status']) {
        AuthCashier authCashier = AuthCashier.fromJson(response.data);
        var data = response.data['data'];
        var dataDetailUser = response.data['data']['detail_user'];
        box.write("token", data['token']);

        //session detail user
        box.write(MyString.USER_ID, authCashier.data!.detailUser!.employeid);
        box.write(MyString.USER_FULLNAME, authCashier.data!.detailUser!.name);
        box.write(
            MyString.USER_NO_HP, authCashier.data!.detailUser!.phonenumber);
        box.write(MyString.USER_EMAIL, '');
        box.write(MyString.USER_USERNAME, authCashier.data!.detailUser!.name);
        box.write(MyString.USER_PHOTO, '');
        box.write(MyString.STORE_COUNT, 1);

        //session role user
        box.write(MyString.ROLE_ID, '');

        box.write(MyString.ROLE_NAME, 'kasir');

        //checking id owner
        box.write(MyString.USER_ID_OWNER, authCashier.data!.detailUser!.userid);

        //user type account
        if (dataDetailUser['store'][0]['owner']['user_type'] != null) {
          box.write(
              MyString.STATUS_CODE_ID,
              dataDetailUser['store'][0]['owner']['user_type']['STATUS_CODE_ID']
                  .toString());
          box.write(MyString.STATUS_NAME,
              dataDetailUser['store'][0]['owner']['user_type']['STATUS_NAME']);
          box.write(MyString.EXPIRED_DATE,
              dataDetailUser['store'][0]['owner']['EXPIRED_DATE']);
        }

        //sessiojn store
        if (authCashier.data!.detailUser!.store!.length > 0) {
          _downloadFile(
                  authCashier.data!.detailUser!.store![0].owner!.business!
                      .businesslogo!,
                  'logo')
              .then((value) {
            print(value.path);
          });
        }

        //session bussines
        box.write(MyString.BUSINESS_ID, '');
        box.write(MyString.BUSINESS_NAME, '');
        box.write(MyString.BUSINESS_CATEGORY_ID, '');
        box.write(MyString.BUSINESS_CATEGORY_NAME, '');
        box.write(MyString.BUSINESS_CREW_TOTAL, '');
        box.write(MyString.BUSINESS_BRANCH, '');
        box.write(MyString.BUSINESS_WEBSITE_ID, '').toString();
        box.write(
            MyString.BUSINESS_CONTACT,
            dataDetailUser['store'][0]['owner']['business']
                ['BUSINESS_CONTACT']);

        Get.offAllNamed(Routes.CHOOSE_STORE, arguments: authCashier);

        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            title: "Login",
            message: 'Selamat Datang ' + authCashier.data!.detailUser!.name!);
        return ResponseMessage(
            message: response.data['message'],
            status: response.data['status'],
            data: authCashier);
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            title: "Login",
            message: response.data['message']);
        return ResponseMessage(
            message: response.data['message'], status: response.data['status']);
      }
    } on DioError catch (e) {
      print(e);
      return ResponseMessage(message: 'Erorr Dari Server', status: false);
    }
  }

  Future<ResponseMessage> updatePassword({String? password}) async {
    try {
      AuthSessionManager auth = AuthSessionManager();
      Map<String, dynamic> data = {
        "id": "${auth.userId}",
        "user_password": "$password"
      };
      response = await dio.post("${MyString.updatePassword}",
          data: jsonEncode(data),
          queryParameters: {"owner_id": "${auth.userId}"},
          options: options);

      return ResponseMessage(
          message: response!.data['message'],
          status: response!.data['code'] == 200 ? true : false);
    } on DioError catch (e) {
      print(e);
      return ResponseMessage(
          message: 'Erorr On API', status: response!.data['status']);
    }
  }

  static var httpClient = new HttpClient();

  Future<File> _downloadFile(String url, String filename) async {
    print(url);
    var box = GetStorage();
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(url)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();
    var dir;
    await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS)
        .then((value) {
      dir = value;
    });
    final targetFile = Directory("$dir/$filename" + ".png");
    if (targetFile.existsSync()) {
      targetFile.deleteSync(recursive: true);
    }
    box.write(MyString.BUSINESS_LOGO, '$dir/$filename' + '.png');

    //
    File file = new File('$dir/$filename' + '.png');
    await Permission.storage.request().then((value) async {
      if (value.isGranted) {
        await file.writeAsBytes(bytes);
        Image image2 = decodeJpg(file.readAsBytesSync());
        Image thumbnail =
            grayscale(copyResize(image2, width: 250, height: 150));
        File('$dir/logo.png').writeAsBytesSync(encodePng(thumbnail));
      }
    });
    if (await Permission.storage.isGranted) {
      await file.writeAsBytes(bytes);
      Image image2 = decodeJpg(file.readAsBytesSync());
      Image thumbnail = grayscale(copyResize(image2, width: 250, height: 150));
      File('$dir/logo.png').writeAsBytesSync(encodePng(thumbnail));
    }

    return file;
  }

  Image grayscale(Image src) {
    final p = src.getBytes();
    for (var i = 0, len = p.length; i < len; i += 4) {
      final l = getLuminanceRgb(p[i], p[i + 1], p[i + 2]);
      p[i] = l;
      p[i + 1] = l;
      p[i + 2] = l;
    }
    return src;
  }

  Future<ResponseMessage> updateUser(
      {String? name, String? email, String? phoneNumber}) async {
    try {
      AuthSessionManager auth = AuthSessionManager();
      options = new Options(headers: {"Authorization": "Bearer ${auth.token}"});
      GetStorage box = GetStorage();
      response = await dio.post("${MyString.updateUsers}",
          data: {
            "user_fullname": "$name",
            "username": "$name",
            "email": "$email",
            "phone_number": "$phoneNumber",
            "user_id": "${auth.userIdOwner}",
          },
          options: options);
      if (response!.statusCode == 201) {
        box.write(MyString.USER_FULLNAME, name);
        box.write(MyString.USER_NO_HP, phoneNumber);
        box.write(MyString.USER_EMAIL, email);
        box.write(MyString.USER_USERNAME, name);
      }
      return ResponseMessage(
          message: response!.data['message'],
          status: response!.data['status'],
          data: response!.data['data']);
    } on DioError catch (e) {
      print(e);
      return throw ServerException();
    }
  }
}
