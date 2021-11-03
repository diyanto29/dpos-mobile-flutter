import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/data/datasource/business/business_data_source.dart';
import 'package:warmi/app/data/datasource/rajaongkir/rajaongkir_remote_data_source.dart';
import 'package:warmi/app/data/datasource/register/register_remote_data_source.dart';
import 'package:warmi/app/data/models/business/business_profile.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/app/data/models/rajaongkir/city.dart';
import 'package:warmi/app/data/models/rajaongkir/province.dart';
import 'package:warmi/app/data/models/rajaongkir/subdistrict.dart';
import 'package:warmi/app/modules/owner/outlet/controllers/outlet_controller.dart';
import 'package:warmi/app/modules/owner/settings/controllers/setup_business_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/core/utils/enum.dart';

class RegisterController extends GetxController {

  final TextEditingController passwordC=TextEditingController();
  final TextEditingController emailC=TextEditingController();
  final TextEditingController noHpC=TextEditingController();
  final TextEditingController fullNameC=TextEditingController();
  RxBool  obscurtText=false.obs;
  RxBool  toggleSwitchBusiness=false.obs;
  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> descC = TextEditingController().obs;
  Rx<TextEditingController> postalCodeC = TextEditingController().obs;
  Rx<TextEditingController> timeOpenC = TextEditingController().obs;
  Rx<TextEditingController> timeCloseC = TextEditingController().obs;
  Rx<TextEditingController> detailAddressC = TextEditingController().obs;
  TextEditingController businessNameC = TextEditingController();
  Rx<TypeBusiness> typeBusiness = TypeBusiness().obs;
  RxString totalCrew = 'Jumlah Karyawan'.obs;
  RxString totalBranch = 'Jumlah Outlet'.obs;
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

  Rx<LoadingState> loadingState = LoadingState.empty.obs;

  //data source
  Rx<BusinessProfileModel> businessProfile = BusinessProfileModel().obs;

  var listTypeBusiness = List<TypeBusiness>.empty().obs;


  @override
  void onInit() {
  getDataSourceTypeBusiness();
  getProvince();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changeObscureText() => obscurtText.value=!obscurtText.value;
  void changeToggleSwitchBusiness() => toggleSwitchBusiness.value=!toggleSwitchBusiness.value;


  //get list province from api
  void getProvince() async {
    await RajaOngkirRemoteDataSource().getProvince().then((value) {
      listProvince(value.rajaongkir!.results);
    });
  }
//get list city by province from api
  void getCity(String? idProvince) async {
    listCity.clear();
    listSubDistrict.clear();
    await RajaOngkirRemoteDataSource().getCity(provinceId: idProvince).then((value) {
      listCity(value.rajaongkir!.Citys);
    });
  }

  //get list subdistrict by city from api
  void getSubDistrict(String? idCity) async {
    await RajaOngkirRemoteDataSource().getSubdistrict(cityId: idCity).then((value) {
      listSubDistrict(value.rajaongkir!.results);
    });
  }

  //get type business
  void getDataSourceTypeBusiness() async {
    loadingState(LoadingState.loading);
    await BusinessDataSource().getTypeBusiness().then((value) {
      listTypeBusiness(value);
    });
    loadingState(LoadingState.empty);
  }


  void register()async{
    loadingBuilder();
    await RegisterRemoteDataSource().register(
      postalCode: postalCodeC.value.text,
      province: toggleSwitchBusiness.value==false ? null :selectedProvince
          .value,
      password: passwordC.text,
      phoneNumber: noHpC.text,
      email: emailC.text,
      addressDetail: detailAddressC.value.text,
      business: typeBusiness.value,
      businessName: businessNameC.text,
      city:toggleSwitchBusiness.value==false ? null: selectedCity.value,
      fullName: fullNameC.text,
      subdistrict: toggleSwitchBusiness.value==false ? null :
      selectedSubDistrict.value,
      username: noHpC.text,
    );
  }
}
