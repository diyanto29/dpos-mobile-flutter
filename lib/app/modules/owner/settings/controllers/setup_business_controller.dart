import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmi/app/data/datasource/business/business_data_source.dart';
import 'package:warmi/app/data/datasource/business/business_profile_data_source.dart';
import 'package:warmi/app/data/models/business/business_profile.dart';
import 'package:warmi/app/data/models/business/type_business.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/utils/enum.dart';

class SetupBusinessController extends GetxController {
  TextEditingController businessNameC = TextEditingController();
  TextEditingController websiteNameC = TextEditingController();
  TextEditingController contactC = TextEditingController();
  RxString totalCrew = 'Jumlah Karyawan'.obs;
  RxString totalBranch = 'Jumlah Outlet'.obs;
  Rx<TypeBusiness> typeBusiness = TypeBusiness().obs;
  File? image;
  final picker = ImagePicker();

  Rx<LoadingState> loadingState = LoadingState.empty.obs;

  //data source
  Rx<BusinessProfileModel> businessProfile = BusinessProfileModel().obs;

  var listTypeBusiness = List<TypeBusiness>.empty().obs;

  @override
  void onInit() {
    getBusinessProfileDataSource();
    getDataSourceTypeBusiness();

    super.onInit();
  }

  void initialization() {
    businessNameC.text = businessProfile.value.data!.businessName ?? '';
    websiteNameC.text = businessProfile.value.data!.businessWebsiteName=="null" ? '' :businessProfile.value.data!.businessWebsiteName.toString();
    contactC.text = businessProfile.value.data!.businessContact ?? '';
    totalCrew(businessProfile.value.data!.businessCrewTotal ?? 'Jumlah Karyawan');
    totalBranch(businessProfile.value.data!.businessBranch ?? 'Jumlah Outlet');
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource, imageQuality: 20);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      Get.back();
    } else {
      print('No image selected.');
    }
    update();
  }

  void showBottomSheetImage() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Container(
          height: 120,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  getImage(ImageSource.camera);
                },
                leading: Icon(IconlyLight.camera),
                title: Text("Ambil Gambar dari Kamera"),
              ),
              ListTile(
                onTap: () {
                  getImage(ImageSource.gallery);
                },
                leading: Icon(IconlyLight.image2),
                title: Text("Ambil Gambar dari Galeri"),
              ),
            ],
          ),
        );
      },
    );
  }

  void getBusinessProfileDataSource() async {
    loadingState(LoadingState.loading);
    await BusinessProfileDataSource().getBusinessProfile().then((value) {
      businessProfile(BusinessProfileModel.fromJson(value));
      print(businessProfile.value.data!.category!.businessCategoryName);
      typeBusiness.value = new TypeBusiness(
          businessCategoryId: businessProfile.value.data!.category!.businessCategoryId,
          businessCategoryName: businessProfile.value.data!.category!.businessCategoryName);
      print(businessProfile.value.data!.businessName);
      initialization();
    });
    update();
    loadingState(LoadingState.empty);
  }

  void getDataSourceTypeBusiness() async {
    loadingState(LoadingState.loading);
    await BusinessDataSource().getTypeBusiness().then((value) {
      listTypeBusiness(value);
    });
    loadingState(LoadingState.empty);
  }

  void updateBusinessProfile() async {
    Get.dialog(Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: MyColor.colorPrimary,
        )));

    await BusinessProfileDataSource().updateBusinessProfile(
        businessName: businessNameC.text,
        typeBusiness: typeBusiness.value,
        branch: totalBranch.value,
        contact: contactC.text,
        crewTotal: totalCrew.value,
        websiteName: websiteNameC.text,
        pathLogo: image,
        fileName: image != null
            ? image!.path.isEmpty
                ? image!.path.split('/').last
                : '...'
            : "...").then((value) {
              if(value){
                Get.back();
                Get.back();
                showSnackBar(snackBarType: SnackBarType.SUCCESS,
                title: 'Warmi',message: 'Berhasil Disimpan');
              }
    });


  }
}
