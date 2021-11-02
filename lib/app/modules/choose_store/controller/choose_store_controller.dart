import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:warmi/app/data/datasource/outlet/outlet_remote_data_source.dart';
import 'package:warmi/app/data/models/auth_cashier/auth_cashier.dart';
import 'package:warmi/app/data/models/outlet/outlet.dart';
import 'package:warmi/app/routes/app_pages.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/enum.dart';

class ChooseStoreController extends GetxController{

  Rx<AuthCashier> authCashier=AuthCashier().obs;
  var listOutlet = List<DataOutlet>.empty().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;

  @override
  void onInit() {

    getOutletDataSource();

    super.onInit();
  }

  void getOutletDataSource() async {
    loadingState(LoadingState.loading);
    await OutletRemoteDataSource().getOutlet().then((value) {
      listOutlet(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void setStoreName(DataOutlet dataOutlet){
    var box=GetStorage();
    box.write(MyString.STORE_ID, dataOutlet.storeId);
    box.write(MyString.STORE_NAME, dataOutlet.storeName);
    String? address;
    if (dataOutlet.address != null) {
      address = "Kec. ${dataOutlet.address!.addressSubdistrictName} ${dataOutlet.address!.addressType}. "
          "${dataOutlet.address!.addressCityName} - "
          "${dataOutlet.address!.addressProvinceName}";
    }
    box.write(MyString.STORE_ADDRESS, address);
    Get.offAllNamed(Routes.INDEX_TRANSACTION);
  }
}