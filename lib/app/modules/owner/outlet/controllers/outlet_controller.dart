import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/outlet/outlet_remote_data_source.dart';
import 'package:warmi/app/data/datasource/rajaongkir/rajaongkir_remote_data_source.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class OutletController extends GetxController {
  RxBool toggleSwitchOutlet = false.obs;

  var listOutlet = List<DataOutlet>.empty().obs;
  var listSearchOutlet = List<DataOutlet>.empty().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> descC = TextEditingController().obs;
  Rx<TextEditingController> postalCodeC = TextEditingController().obs;
  Rx<TextEditingController> timeOpenC = TextEditingController().obs;
  Rx<TextEditingController> timeCloseC = TextEditingController().obs;
  Rx<TextEditingController> detailAddressC = TextEditingController().obs;
  var listProvince = List<Province>.empty().obs;
  var listCity = List<City>.empty().obs;
  var listSubDistrict = List<Subdistrict>.empty().obs;

  Rx<TimeOfDay?> timeOpen = TimeOfDay.now().obs;
  Rx<TimeOfDay?> timeClose = TimeOfDay.now().obs;
  late Province province;
  late City city;
  Rx<City?> selectedCity = City().obs;
  Rx<Province?> selectedProvince = Province().obs;
  Rx<Subdistrict?> selectedSubDistrict = Subdistrict().obs;
  Rx<AuthSessionManager> auth = AuthSessionManager().obs;

  @override
  void onInit() {

    getOutletDataSource();
    getProvince();
    super.onInit();
  }

  void getOutletDataSource() async {
    loadingState(LoadingState.loading);
    await OutletRemoteDataSource().getOutlet().then((value) {
      listOutlet(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void searchOutlet(String keyword) async {
    loadingState(LoadingState.loading);
    await listSearchOutlet(listOutlet.where((item) => item.storeName.toString().toLowerCase().contains(keyword.toLowerCase())).toList());
    loadingState(LoadingState.empty);
  }

  void getProvince() async {
    await RajaOngkirRemoteDataSource().getProvince().then((value) {
      listProvince(value.rajaongkir!.results);
      // print(listProvince[0].province);
    });
  }

  void getCity(String? idProvince) async {
    listCity.clear();
    listSubDistrict.clear();
    await RajaOngkirRemoteDataSource().getCity(provinceId: idProvince).then((value) {
      listCity(value.rajaongkir!.Citys);
    });
  }

  void getSubDistrict(String? idCity) async {
    await RajaOngkirRemoteDataSource().getSubdistrict(cityId: idCity).then((value) {
      listSubDistrict(value.rajaongkir!.results);
    });
  }

  void createOrupdate({bool edit = false, String? storeId}) async {
    if (nameC.value.text.isEmpty) {
      showSnackBar(snackBarType: SnackBarType.INFO, title: 'Outlet', message: "Nama Wajib diisi");
      return;
    }
    if (toggleSwitchOutlet.value && selectedProvince.value!.provinceId==null) {
      showSnackBar(snackBarType: SnackBarType.INFO, title: 'Outlet', message:
      "Atur Alamat Toko Anda");
      return;
    }

    loadingBuilder();
    await OutletRemoteDataSource()
        .insertOrUpdateStore(
            edit: edit,
            storeId: storeId,
            name: nameC.value.text,
            desc: descC.value.text,
            operationStart: timeOpenC.value.text,
            operationClose: timeCloseC.value.text,
            address: selectedProvince.value!.provinceId==null ? null : new
            Address(
                addressAlias: detailAddressC.value.text,
                addressPoscode: postalCodeC.value.text,
                addressNoTelp: '-',
                addressType: selectedCity.value!.type,
                addressProvinceId: int.parse(selectedProvince.value!
                    .provinceId!),
                addressProvinceName:selectedProvince.value!
                    .province,
                addressCityId: int.parse(selectedCity.value!.cityId!),
                addressCityName: selectedCity.value!.cityName,
                addressSubdistrictId: int.parse(selectedSubDistrict.value!.subdistrictId!),
                addressSubdistrictName: selectedSubDistrict.value!.subdistrictName))
        .then((value) {
      nameC.value.text = "";
      descC.value.text = "";
      selectedCity.value= new City();
      selectedSubDistrict(new Subdistrict());
      selectedProvince(new Province());
      timeCloseC.value.text = "";
      timeOpenC.value.text = "";
      postalCodeC.value.text = "";
      detailAddressC.value.text = "";
      toggleSwitchOutlet(false);
      Get.back();
      if (value.status) {
        getOutletDataSource();
        Get.back();

        showSnackBar(snackBarType: SnackBarType.SUCCESS, title: 'Outlet', message: ''
            'Data Berhasil Disimpan');
      } else {
        showSnackBar(snackBarType: SnackBarType.ERROR, title: 'Outlet', message: "${value.message}");
      }
    });
  }

  void deleteOutlet(String id) async {
    loadingBuilder();
    await OutletRemoteDataSource().deleteStore(idStore: id).then((value) {
      Get.back();
      if (value.status) getOutletDataSource();
      showSnackBar(snackBarType: SnackBarType.SUCCESS, title: "Outlet", message: value.message);
    });
  }

  selectTimeOpen() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: Get.context!,
        initialTime: timeOpen.value!,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    if (timeOfDay != null && timeOfDay != timeOpen.value!) {
      timeOpen.value = timeOfDay;
      timeOpenC.value.text = timeOfDay.hour < 10 ? "0" + timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString() : timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();
    }
  }

  selectTimeClose() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: Get.context!,
        initialTime: timeClose.value!,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    if (timeOfDay != null && timeOfDay != timeClose.value!) {
      timeClose.value = timeOfDay;
      timeCloseC.value.text = timeOfDay.hour < 10 ? "0" + timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString() : timeOfDay.hour.toString() + ":" + timeOfDay.minute.toString();
    }
  }

  void changeOutlet({DataOutlet? dataOutlet}) async {
   AuthSessionManager auth = AuthSessionManager();
   auth.getSessionFromLocal();
    GetStorage box = GetStorage();
    String? address;
    if (dataOutlet!.address != null) {
      address = "Kec. ${dataOutlet.address!.addressSubdistrictName} ${dataOutlet.address!.addressType}. "
          "${dataOutlet.address!.addressCityName} - "
          "${dataOutlet.address!.addressProvinceName}";
    }
    box.write(MyString.STORE_ID, dataOutlet.storeId);
    box.write(MyString.STORE_NAME, dataOutlet.storeName);
    box.write(MyString.STORE_ADDRESS, address);
    if (auth.roleName == "Pemilik Toko") Get.offAllNamed(Routes.NAVIGATION);
  }

  void copyToClipboard(String data){
    FlutterClipboard.copy(data).then(( value ) {
      showSnackBar(snackBarType: SnackBarType.SUCCESS, title: "Outlet", message: 'Berhasil Disalin');
    });
  }

  void shareWebsite(String data,String storeName){
    Share.share(data,subject: 'Toko Online $storeName');
  }
}
