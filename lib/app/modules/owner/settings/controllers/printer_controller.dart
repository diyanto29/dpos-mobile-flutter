import 'dart:typed_data';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:pos_printer_manager/enums/connection_type.dart';
import 'package:pos_printer_manager/enums/connection_type.dart';
import 'package:pos_printer_manager/enums/connection_type.dart';
// @dart=2.9
import 'package:pos_printer_manager/pos_printer_manager.dart'  as usb;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:warmi/app/data/datalocal/session/auth_session_manager.dart';
import 'package:warmi/app/data/datasource/printer/printer_remote_data_source.dart';
import 'package:warmi/app/data/models/printer/printer_model.dart';
import 'package:warmi/app/data/models/report_transaction/report_transaction.dart';
import 'package:warmi/app/data/models/report_transaction/report_transaction_by_category.dart';
import 'package:warmi/app/data/models/transactions/transaction_model.dart';
import 'package:warmi/app/modules/history_sales/controllers/history_sales_controller.dart';

import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_loading.dart';
import 'package:warmi/app/modules/wigets/layouts/dialog/dialog_snackbar.dart';
import 'package:warmi/app/modules/wigets/package/dropdown__search/dropdown_search.dart';
import 'package:warmi/core/globals/global_string.dart';
import 'package:warmi/core/utils/demo_usb.dart';
import 'package:warmi/core/utils/enum.dart';
import 'dart:io';
import 'package:recase/recase.dart';
import 'package:warmi/core/utils/service.dart';
import 'package:warmi/core/utils/webview_helper.dart';
import 'package:warmi/main.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

import 'invoce_controller.dart';

class PrinterController extends GetxController {
  List<BluetoothInfo> availableBluetoothDevices = [];

  //
  var listPrinterDevice = List<PrinterData>.empty().obs;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  var box = GetStorage();
  var invoiceC = Get.isRegistered<InvoiceController>()
      ? Get.find<InvoiceController>()
      : Get.put(InvoiceController());

  int groupValueFontTypeHeader = 1;
  int groupValueFontTypeFooter = 1;
  int groupValueFontTypeContent = 1;
  int groupValueFontTypeTotal = 1;
  String? fontSizeHeader, fontSizeFooter, fontSizeContent, fontSizeTotal;


  var  isLoading = true;
  List<usb.USBPrinter> printers = [];
   usb.USBPrinterManager?  managerUSB;



  @override
  void onInit() {
    invoiceC.getInvoice();
    invoiceC.readSessionInvoice();
    getPrinterRemoteDataSource();
    getStylePrint();
    scan();
    super.onInit();
  }

  void getStylePrint() async {
    groupValueFontTypeHeader = box.read(MyString.TYPE_FONT_HEADER);
    fontSizeHeader = box.read(MyString.FONT_HEADER);

    groupValueFontTypeFooter = box.read(MyString.TYPE_FONT_FOOTER);
    fontSizeFooter = box.read(MyString.FONT_FOOTER);

    groupValueFontTypeContent = box.read(MyString.TYPE_FONT_CONTENT);
    fontSizeContent = box.read(MyString.FONT_CONTENT);

    groupValueFontTypeTotal = box.read(MyString.TYPE_FONT_TOTAL);
    fontSizeTotal = box.read(MyString.FONT_TOTAL);
  }

  Future<void> scanBluetooth() async {
    final List<BluetoothInfo> bluetooths =
        await PrintBluetoothThermal.pairedBluetooths;
    print("Print $bluetooths");
    availableBluetoothDevices = bluetooths;
    update();
  }

  Future scan() async {

      isLoading = true;

        update();
    printers = await usb.USBPrinterManager.discover();
    isLoading = false;
      update();

  }

  Future connect(usb.USBPrinter printer) async {
    var paperSize = usb.PaperSize.mm58;
    var profile = await usb.CapabilityProfile.load();
    var manager = usb.USBPrinterManager(printer, paperSize, profile);
    await manager.connect();
    print(fontSizeHeader);
    print("sada");
      managerUSB = manager;

      printer.connected = true;
      box.write("printerID", printer.id);
      box.write("printerName", printer.name);
      box.write("address", printer.address);
      box.write("deviceId", printer.deviceId);
      box.write("vendorId", printer.vendorId);
      box.write("vendorId", printer.vendorId);
      box.write("productId", printer.productId);
      box.write("productId", printer.productId);
      box.write("connected", printer.connected);
      box.write("type", printer.type);
      box.write("ConnectionType", printer.connectionType.toString());
      print(box.read("ConnectionType"));


  }

  void printFromUSb()async{

  }

  void startPrinter() async {

      // final content = usb.Demo.getShortReceiptContent();
      // var bytes = await WebcontentConverter.contentToImage(
      //   content: content,
      //   executablePath: WebViewHelper.executablePath(),
      // );
      // var service = ESCPrinterService(bytes);
      // var data = await service.getBytes();
      // if (mounted) setState(() => _data = data);
      //

    // List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();



    final generator = Generator(PaperSize.mm58, profile);
    final content = await contentWeb();
    var bytes = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
    );
    var service = ESCPrinterService(bytes);
    var data = await service.getBytes();
    if (managerUSB != null) {
      print("isConnected ${managerUSB!.isConnected}");
      managerUSB!.writeBytes(data, isDisconnect: false);
    }
  }
  void startPrinterUSB({DataTransaction? dataTransaction, bool printCopy = false}) async {

      // final content = usb.Demo.getShortReceiptContent();
      // var bytes = await WebcontentConverter.contentToImage(
      //   content: content,
      //   executablePath: WebViewHelper.executablePath(),
      // );
      // var service = ESCPrinterService(bytes);
      // var data = await service.getBytes();
      // if (mounted) setState(() => _data = data);

    box.read("address");
    ;
    ;
    box.read("vendorId");
    ;
    box.read("productId");
    ;
    ;
    box.read("ConnectionType");
    print(box.read("ConnectionType"));
    usb.USBPrinter printUSB=usb.USBPrinter(
      id:box.read("printerID"),
      type:box.read("type"),
      name:box.read("printerName"),
      address: box.read("address"),
      deviceId: box.read("deviceId"),
      vendorId: box.read("vendorId"),
      productId:box.read("productId"),
      connected:box.read("connected"),
      connectionType:box.read("ConnectionType")=="ConnectionType.usb" ? ConnectionType.usb : ConnectionType.usb
    );

    connect(printUSB);
    // List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    // final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = await getTicketPurchaseUSB(
        dataTransaction: dataTransaction, printCopy: printCopy);

    print("asdadasdasd");
    if (managerUSB != null) {
      print("isConnected ${managerUSB!.isConnected}");
      managerUSB!.writeBytes(bytes, isDisconnect: false);
    }
  }

  Future<void> setConnect(String mac) async {
    final bool? result =
        await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    print("state conneected $result");
    if (result!) {
      print("a");
    }
  }

  Future<List<int>> getGraphicsTicket() async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    // Print QR Code using native function
    bytes += generator.qrcode('example.com');

    bytes += generator.hr();

    // Print Barcode using native function
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.cut();

    return bytes;
  }

  Future<List<int>> getLogoDPos() async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    final ByteData data = await rootBundle.load('assets/icons/d-post.png');
    final Uint8List bytes2 = data.buffer.asUint8List();
    final Image? image = decodeImage(bytes2);
// Using `ESC *`
    generator.image(image!);
// Using `GS v 0` (obsolete)
    generator.imageRaster(image);
// Using `GS ( L`
    generator.imageRaster(image, imageFn: PosImageFn.graphics);

    return bytes;
  }

  Future<void> printTicket({String? mac}) async {
    bool? isConnected = await PrintBluetoothThermal.connectionStatus;
    if (isConnected) {
      List<int> bytes = await getTicket();
      final result = await PrintBluetoothThermal.writeBytes(bytes);
      print("Print $result");
    } else {
      var a = await PrintBluetoothThermal.connect(macPrinterAddress: mac!);
      List<int> bytes = await getTicket();
      final result = await PrintBluetoothThermal.writeBytes(bytes);
    }
  }

  Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    bytes += generator.text("Demo Shop",
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += generator.text(
        "18th Main Road, 2nd Phase, J. P. Nagar, Bengaluru, Karnataka 560078",
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Tel: +919591708470',
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: 'No',
          width: 1,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Item',
          width: 5,
          styles: PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Price',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: PosStyles(align: PosAlign.right, bold: true)),
    ]);

    bytes += generator.row([
      PosColumn(text: "1", width: 1),
      PosColumn(
          text: "Tea",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "10",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "10", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: "2", width: 1),
      PosColumn(
          text: "Sada Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "30",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "30", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: "3", width: 1),
      PosColumn(
          text: "Masala Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "50",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "50", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.row([
      PosColumn(text: "4", width: 1),
      PosColumn(
          text: "Rova Dosa",
          width: 5,
          styles: PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "70",
          width: 2,
          styles: PosStyles(
            align: PosAlign.center,
          )),
      PosColumn(text: "1", width: 2, styles: PosStyles(align: PosAlign.center)),
      PosColumn(text: "70", width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            height: PosTextSize.size4,
            width: PosTextSize.size4,
          )),
      PosColumn(
          text: "160",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size4,
            width: PosTextSize.size4,
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    // ticket.feed(2);
    bytes += generator.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text("26-11-2020 15:22:45",
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.text(
        'Note: Goods once sold will not be taken back or exchanged.',
        styles: PosStyles(align: PosAlign.center, bold: false));
    bytes += generator.cut();
    return bytes;
  }

  Future<List<int>> setPaperPrinter({String? paper}) async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator;
    if (paper == "80")
      generator = Generator(PaperSize.mm80, profile);
    else
      generator = Generator(PaperSize.mm58, profile);
    final ByteData data = await rootBundle.load('assets/store.png');
    final Uint8List imgBytes = data.buffer.asUint8List();

    bytes += generator.text("TEST PRINTER ",
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.text("TIPE FONT A");
    bytes += generator.hr();
    bytes += generator.setGlobalFont(PosFontType.fontB);
    bytes += generator.text("TIPE FONT B");
    bytes += generator.hr();
    bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.text(
      "Font Size 1",
      styles: PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ),
    );
    bytes += generator.hr();
    bytes += generator.text(
      "Font Size 2",
      styles: PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    );
    bytes += generator.hr();
    bytes += generator.text(
      "Font Size 3",
      styles: PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size3,
        width: PosTextSize.size3,
      ),
    );
    bytes += generator.hr();
    bytes += generator.text(
      "Font Size 4",
      styles: PosStyles(
        align: PosAlign.left,
        height: PosTextSize.size5,
        width: PosTextSize.size4,
      ),
    );

    bytes += generator.text("BY DPOS OFFICIAL",
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.hr();
    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }

  Future<void> printTest({PrinterData? printerData, String? mac}) async {
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (result) {
      loadingBuilder();
      bool printTest = true;
      await PrintBluetoothThermal.disconnect;
      if (mac == null) {
        if (printerData!.printerport == null) {
          bool? isConnected = await PrintBluetoothThermal.connectionStatus;
          if (isConnected) {
            //SET PRINTER DEFAULT
            box.write(MyString.DEFAULT_PRINTER, printerData.printermac);
            box.write(MyString.PRINTER_PAPER, printerData.printerpapertype);
            box.write(MyString.PRINTER_TYPE, "bluetooth");

            List<int> bytes =
                await setPaperPrinter(paper: printerData.printerpapertype);
            final result = await PrintBluetoothThermal.writeBytes(bytes);
          } else {
            var a = await PrintBluetoothThermal.connect(
                    macPrinterAddress: printerData.printermac!)
                .then((value) {
              if (value) {
                printTest = true;
                //SET PRINTER DEFAULT
                box.write(MyString.DEFAULT_PRINTER, printerData.printermac);
                box.write(MyString.PRINTER_PAPER, printerData.printerpapertype);
                box.write(MyString.PRINTER_TYPE, "bluetooth");
              } else
                printTest = false;
            });
            List<int> bytes = await setPaperPrinter();
            final result = await PrintBluetoothThermal.writeBytes(bytes);
          }
        }
      } else {
        bool? isConnected = await PrintBluetoothThermal.connectionStatus;
        if (isConnected) {
          List<int> bytes = await setPaperPrinter(paper: "58");

          //SET PRINTER DEFUALT
          box.write(MyString.DEFAULT_PRINTER, mac);
          box.write(MyString.PRINTER_PAPER, "58");
          box.write(MyString.PRINTER_TYPE, "bluetooth");
          final result = await PrintBluetoothThermal.writeBytes(bytes);

          print("Print $result");
        } else {
          var a = await PrintBluetoothThermal.connect(macPrinterAddress: mac)
              .then((value) {
            if (value) {
              //SET PRINTER DEFUALT
              box.write(MyString.DEFAULT_PRINTER, mac);
              box.write(MyString.PRINTER_PAPER, "58");
              box.write(MyString.PRINTER_TYPE, "bluetooth");
              printTest = true;
            } else
              printTest = false;
          });

          List<int> bytes = await setPaperPrinter();
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        }
      }

      Get.back();
      if (printTest) {
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            message: "Printing Success",
            title: "Print");
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            message: "Printing Gagal! Periksa Bluetooth di kedua device anda",
            title: "Print");
      }
    } else {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Bluetooth Anda tidak Aktif",
          title: "Print");
    }
  }

  void getPrinterRemoteDataSource() async {
    await PrinterRemoteDataSource().getPrinterDevice().then((value) {
      listPrinterDevice(value.data);
    });
    loadingState(LoadingState.empty);
  }

  void storePrinter(
      {String? printerName,
      String? printerMac,
      String? printerIp,
      String? paperType,
      String? printerId}) async {
    loadingBuilder();
    await PrinterRemoteDataSource()
        .storePrinter(
            printerName: printerName,
            printerId: printerId,
            paperType: paperType,
            printerIp: printerIp,
            printerMac: printerMac)
        .then((value) {
      Get.back();
      Get.back();
      box.write(MyString.DEFAULT_PRINTER, printerMac);
      box.write(MyString.PRINTER_PAPER, paperType);
      box.write(MyString.PRINTER_TYPE, "bluetooth");
      if (value.status) getPrinterRemoteDataSource();
      showSnackBar(
          snackBarType: SnackBarType.SUCCESS,
          title: "Printer",
          message: value.message);
    });
  }

  void deletePrinter(String? id) async {
    loadingBuilder();
    await PrinterRemoteDataSource().deletePrinter(id: id).then((value) {
      Get.back();
      Get.back();
      if (value.status) getPrinterRemoteDataSource();
      showSnackBar(
          snackBarType: SnackBarType.SUCCESS,
          title: "Printer",
          message: value.message);
    });
  }

  //print invoice form sales
  void printTicketPurchase(
      {DataTransaction? dataTransaction, bool printCopy = false}) async {
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (result) {
      // loadingBuilder();
      bool printTest = true;

      await PrintBluetoothThermal.disconnect;
      if (box.read(MyString.PRINTER_TYPE) == "bluetooth") {
        bool? isConnected = await PrintBluetoothThermal.connectionStatus;
        if (isConnected) {
          List<int> bytes = await getTicketPurchase(
              dataTransaction: dataTransaction, printCopy: printCopy);
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        } else {
          var a = await PrintBluetoothThermal.connect(
                  macPrinterAddress: box.read(MyString.DEFAULT_PRINTER))
              .then((value) {
            if (value)
              printTest = true;
            else
              printTest = false;
          });
          List<int> bytes = await getTicketPurchase(
              dataTransaction: dataTransaction, printCopy: printCopy);
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        }
      }

      // Get.back();
      if (printTest) {
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            message: "Printing Success",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            message: "Printing Gagal! Periksa Bluetooth di kedua device anda",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      }
    } else {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Bluetooth Anda tidak Aktif",
          title: "Print");
      var controller = Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());

      if (controller.isInterstitialAdReady)
        Future.delayed(Duration(seconds: 2), () {
          controller.interstitialAd.show();
        });
    }
  }

  Future<List<int>> getTicketPurchase(
      {DataTransaction? dataTransaction, bool printCopy = false}) async {
    var auth = AuthSessionManager();
    var historyC = Get.find<HistorySalesController>();
    historyC.getSubtotal(dataTransaction!);
    getStylePrint();



    List<int> bytes = [];
    print(box.read(MyString.PRINTER_PAPER));
    CapabilityProfile profile = await CapabilityProfile.load(name: 'RP80USE');

    final generator;
    if (box.read(MyString.PRINTER_PAPER) == "80")
      generator = Generator(PaperSize.mm80, profile);
    else
      generator = Generator(PaperSize.mm58, profile);
    bytes += generator.setGlobalCodeTable('CP437');

    // bytes += generator.setGlobalFont(PosFontType.fontB);

// print(dir);

//
    if(GetPlatform.isAndroid){
      if (invoiceC.logo.value) {
        File file = new File(box.read(MyString.BUSINESS_LOGO));

        final Uint8List imgBytes = file.readAsBytesSync();
        final Image image = decodeImage(imgBytes)!;
        Image thumbnail = copyResize(image, width: 250, height: 150);

        bytes += generator.image(thumbnail);
      }
    }

    bytes += generator.text(auth.storeName,
        styles: PosStyles(
          align: PosAlign.center,
          fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
          height: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
          width: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
        ),
        linesAfter: 0);

    bytes += generator.text(
        box.read(MyString.STORE_ADDRESS) == null
            ? "-"
            : box.read(MyString.STORE_ADDRESS),
        styles: PosStyles(
          align: PosAlign.center,
          fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
          height: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
          width: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
        ));
    bytes += generator.text('Whatsapp: ${box.read(MyString.BUSINESS_CONTACT)}',
        styles: PosStyles(
          align: PosAlign.center,
          fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
          height: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
          width: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                      ? PosTextSize.size2
                      : PosTextSize.size1,
        ));

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: DateFormat("dd MMM yyyy", "id-ID")
              .format(DateTime.parse(dataTransaction.createdAt!)),
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
      PosColumn(
          text: DateFormat("HH:mm:ss", "id-ID")
              .format(DateTime.parse(dataTransaction.createdAt!)),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: "No. Transaksi",
          width: 6,
          styles: PosStyles(align: PosAlign.left)),
      PosColumn(
          text: dataTransaction.transactionid!.split('-')[0],
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: "Kasir",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
      PosColumn(
          text: dataTransaction.createdBy!.userfullname!,
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);

    bytes += generator.row([
      PosColumn(
          text: "Metode Pembayaran",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
      PosColumn(
          text: dataTransaction.paymentMethod == null
              ? 'Cash'
              : "${dataTransaction.paymentMethod!.type!.paymentmethodtypename.toString().titleCase} -  ${dataTransaction.paymentMethod!.paymentmethodname.toString().capitalize}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                    ? PosTextSize.size3
                    : fontSizeHeader == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);

    if (dataTransaction.customerpartnerid!=null) {
      bytes += generator.row([
        PosColumn(
            text: "Pelanggan",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                      ? PosTextSize.size3
                      : fontSizeHeader == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                      ? PosTextSize.size3
                      : fontSizeHeader == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
        PosColumn(
            text:
                "${dataTransaction.customerDetail['CUSTOMER_PARTNER_NAME'].toString().titleCase}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                      ? PosTextSize.size3
                      : fontSizeHeader == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                      ? PosTextSize.size3
                      : fontSizeHeader == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
      ]);
    }
    bytes += generator.hr();
    dataTransaction.detail!.forEach((item) {
      bytes += generator.text(item.product!.productname,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          ));
      bytes += generator.row([
        PosColumn(
            text:
                "${item.detailtransactionqtyproduct} x Rp ${formatCurrency.format(item.detailtransactionpriceproduct)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                      ? PosTextSize.size3
                      : fontSizeContent == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                      ? PosTextSize.size3
                      : fontSizeContent == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
        PosColumn(
            text:
                "${formatCurrency.format(int.tryParse(item.detailtransactionsubtotal!))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                      ? PosTextSize.size3
                      : fontSizeContent == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                      ? PosTextSize.size3
                      : fontSizeContent == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
      ]);

      if ((int.tryParse(item.detailtransactionsubtotal!)! -
              item.priceafterdiscount!) >
          0) {
        bytes += generator.row([
          PosColumn(
              text: 'diskon'.tr,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
                fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
                height: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                        ? PosTextSize.size3
                        : fontSizeContent == "size2"
                            ? PosTextSize.size2
                            : PosTextSize.size1,
                width: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                        ? PosTextSize.size3
                        : fontSizeContent == "size2"
                            ? PosTextSize.size2
                            : PosTextSize.size1,
              )),
          PosColumn(
              text:
                  "- ${formatCurrency.format((int.tryParse(item.detailtransactionsubtotal!)! - item.priceafterdiscount!))}",
              width: 6,
              styles: PosStyles(
                align: PosAlign.right,
                fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
                height: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                        ? PosTextSize.size3
                        : fontSizeContent == "size2"
                            ? PosTextSize.size2
                            : PosTextSize.size1,
                width: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                        ? PosTextSize.size3
                        : fontSizeContent == "size2"
                            ? PosTextSize.size2
                            : PosTextSize.size1,
              )),
        ]);
      }
    });
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: "Sub Total",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text: "${formatCurrency.format(
            historyC.subTotal.value,
          )}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);

    print(int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0")!);
    if (int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0")! > 0) {
      print("masuk sni");
      bytes += generator.row([
        PosColumn(
            text: 'diskon'.tr,
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
        PosColumn(
            text:
                "- ${formatCurrency.format(int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
      ]);
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: "Total Bayar",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                    ? PosTextSize.size3
                    : fontSizeTotal == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                    ? PosTextSize.size3
                    : fontSizeTotal == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
      PosColumn(
          text:
              "${formatCurrency.format(int.tryParse(dataTransaction.transactiontotal ?? "0"))}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                    ? PosTextSize.size3
                    : fontSizeTotal == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                    ? PosTextSize.size3
                    : fontSizeTotal == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
          )),
    ]);
    if (dataTransaction.paymentMethod == null) {
      bytes += generator.row([
        PosColumn(
            text: "Bayar",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
        PosColumn(
            text:
                "${formatCurrency.format(int.tryParse(dataTransaction.transactionpay ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
      ]);
      bytes += generator.row([
        PosColumn(
            text: "change".tr,
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
        PosColumn(
            text:
                "${formatCurrency.format(int.tryParse(dataTransaction.transactionreceived ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                      ? PosTextSize.size3
                      : fontSizeTotal == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
            )),
      ]);
    }
    var footer;
    if (box.hasData(MyString.FOOTER_TEXT)) {
      footer = box.read(MyString.FOOTER_TEXT);
    } else {
      footer = "Terima Kasih berbelanja";
      box.write(MyString.FOOTER_TEXT, footer);
    }

    if (printCopy)
      bytes += generator.text('+++++++Salinan+++++++',
          styles: PosStyles(
              align: PosAlign.center,
              fontType: groupValueFontTypeFooter == 1
                  ? PosFontType.fontA
                  : PosFontType.fontB,
              height: fontSizeFooter == "size4"
                  ? PosTextSize.size4
                  : fontSizeFooter == "size3"
                      ? PosTextSize.size3
                      : fontSizeFooter == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              width: fontSizeFooter == "size4"
                  ? PosTextSize.size4
                  : fontSizeFooter == "size3"
                      ? PosTextSize.size3
                      : fontSizeFooter == "size2"
                          ? PosTextSize.size2
                          : PosTextSize.size1,
              bold: true));
    bytes += generator.text(box.read(MyString.FOOTER_TEXT),
        styles: PosStyles(
            align: PosAlign.center,
            fontType: groupValueFontTypeFooter == 1
                ? PosFontType.fontA
                : PosFontType.fontB,
            height: fontSizeFooter == "size4"
                ? PosTextSize.size4
                : fontSizeFooter == "size3"
                    ? PosTextSize.size3
                    : fontSizeFooter == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            width: fontSizeFooter == "size4"
                ? PosTextSize.size4
                : fontSizeFooter == "size3"
                    ? PosTextSize.size3
                    : fontSizeFooter == "size2"
                        ? PosTextSize.size2
                        : PosTextSize.size1,
            bold: true));
    bytes += generator.text("Powered by DPOS",
        styles: PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    bytes += generator.drawer();
    bytes += generator.cut();
    return bytes;
  }



  Future<List<int>> getTicketPurchaseUSB(
      {DataTransaction? dataTransaction, bool printCopy = false}) async {
    var auth = AuthSessionManager();
    var historyC = Get.find<HistorySalesController>();
    historyC.getSubtotal(dataTransaction!);
    // getStylePrint();

    List<int> bytes = [];
    print(box.read(MyString.PRINTER_PAPER));
    CapabilityProfile profile = await CapabilityProfile.load();

    final generator;
    if (box.read(MyString.PRINTER_PAPER) == "80")
      generator = Generator(PaperSize.mm80, profile);
    else
      generator = Generator(PaperSize.mm58, profile);
    bytes += generator.setGlobalCodeTable('CP437');

    // bytes += generator.setGlobalFont(PosFontType.fontB);

// print(dir);

//
    if(GetPlatform.isAndroid){
      if (invoiceC.logo.value) {
        File file = new File(box.read(MyString.BUSINESS_LOGO));

        final Uint8List imgBytes = file.readAsBytesSync();
        final Image image = decodeImage(imgBytes)!;
        Image thumbnail = copyResize(image, width: 250, height: 150);

        bytes += generator.image(thumbnail);
      }
    }

    bytes += generator.text(auth.storeName,
        styles: PosStyles(
          align: PosAlign.center,
          fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
          height:
               PosTextSize.size3,
          width:
               PosTextSize.size1,
        ),
        linesAfter: 0);

    bytes += generator.text(
        box.read(MyString.STORE_ADDRESS) == null
            ? "-"
            : box.read(MyString.STORE_ADDRESS),
        styles: PosStyles(
          align: PosAlign.center,
          fontType:     PosFontType.fontB,
          height:
               PosTextSize.size1,
          width:  PosTextSize.size1,
        ));
    bytes += generator.text('Whatsapp: ${box.read(MyString.BUSINESS_CONTACT)}',
        styles: PosStyles(
          align: PosAlign.center,
          fontType:    PosFontType.fontB,
          height: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
              ? PosTextSize.size3
              : fontSizeHeader == "size2"
              ? PosTextSize.size2
              : PosTextSize.size1,
          width: fontSizeHeader == "size4"
              ? PosTextSize.size4
              : fontSizeHeader == "size3"
              ? PosTextSize.size3
              : fontSizeHeader == "size2"
              ? PosTextSize.size2
              : PosTextSize.size1,
        ));

    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: DateFormat("dd MMM yyyy", "id-ID")
              .format(DateTime.parse(dataTransaction.createdAt!)),
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text: DateFormat("HH:mm:ss", "id-ID")
              .format(DateTime.parse(dataTransaction.createdAt!)),
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: "No. Transaksi",
          width: 6,
          styles: PosStyles(align: PosAlign.left)),
      PosColumn(
          text: dataTransaction.transactionid!.split('-')[0],
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);
    bytes += generator.row([
      PosColumn(
          text: "Kasir",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text: dataTransaction.createdBy!.userfullname!,
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);

    bytes += generator.row([
      PosColumn(
          text: "Metode Pembayaran",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text: dataTransaction.paymentMethod == null
              ? 'Cash'
              : "${dataTransaction.paymentMethod!.type!.paymentmethodtypename.toString().titleCase} -  ${dataTransaction.paymentMethod!.paymentmethodname.toString().capitalize}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeHeader == "size4"
                ? PosTextSize.size4
                : fontSizeHeader == "size3"
                ? PosTextSize.size3
                : fontSizeHeader == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);

    if (dataTransaction.customerpartnerid!=null) {
      bytes += generator.row([
        PosColumn(
            text: "Pelanggan",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
        PosColumn(
            text:
            "${dataTransaction.customerDetail['CUSTOMER_PARTNER_NAME'].toString().titleCase}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeHeader==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeHeader == "size4"
                  ? PosTextSize.size4
                  : fontSizeHeader == "size3"
                  ? PosTextSize.size3
                  : fontSizeHeader == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
      ]);
    }
    bytes += generator.hr();
    dataTransaction.detail!.forEach((item) {
      bytes += generator.text(item.product!.productname,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          ));
      bytes += generator.row([
        PosColumn(
            text:
            "${item.detailtransactionqtyproduct} x Rp ${formatCurrency.format(item.detailtransactionpriceproduct)}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                  ? PosTextSize.size3
                  : fontSizeContent == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                  ? PosTextSize.size3
                  : fontSizeContent == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
        PosColumn(
            text:
            "${formatCurrency.format(int.tryParse(item.detailtransactionsubtotal!))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                  ? PosTextSize.size3
                  : fontSizeContent == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeContent == "size4"
                  ? PosTextSize.size4
                  : fontSizeContent == "size3"
                  ? PosTextSize.size3
                  : fontSizeContent == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
      ]);

      if ((int.tryParse(item.detailtransactionsubtotal!)! -
          item.priceafterdiscount!) >
          0) {
        bytes += generator.row([
          PosColumn(
              text: 'diskon'.tr,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
                fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
                height: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                    ? PosTextSize.size2
                    : PosTextSize.size1,
                width: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                    ? PosTextSize.size2
                    : PosTextSize.size1,
              )),
          PosColumn(
              text:
              "- ${formatCurrency.format((int.tryParse(item.detailtransactionsubtotal!)! - item.priceafterdiscount!))}",
              width: 6,
              styles: PosStyles(
                align: PosAlign.right,
                fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
                height: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                    ? PosTextSize.size2
                    : PosTextSize.size1,
                width: fontSizeContent == "size4"
                    ? PosTextSize.size4
                    : fontSizeContent == "size3"
                    ? PosTextSize.size3
                    : fontSizeContent == "size2"
                    ? PosTextSize.size2
                    : PosTextSize.size1,
              )),
        ]);
      }
    });
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: "Sub Total",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text: "${formatCurrency.format(
            historyC.subTotal.value,
          )}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeContent==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeContent == "size4"
                ? PosTextSize.size4
                : fontSizeContent == "size3"
                ? PosTextSize.size3
                : fontSizeContent == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);

    print(int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0")!);
    if (int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0")! > 0) {
      print("masuk sni");
      bytes += generator.row([
        PosColumn(
            text: 'diskon'.tr,
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
        PosColumn(
            text:
            "- ${formatCurrency.format(int.tryParse(dataTransaction.transactionpriceoffvoucher ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
      ]);
    }
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
          text: "Total Bayar",
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
            fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                ? PosTextSize.size3
                : fontSizeTotal == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                ? PosTextSize.size3
                : fontSizeTotal == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
      PosColumn(
          text:
          "${formatCurrency.format(int.tryParse(dataTransaction.transactiontotal ?? "0"))}",
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
            height: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                ? PosTextSize.size3
                : fontSizeTotal == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeTotal == "size4"
                ? PosTextSize.size4
                : fontSizeTotal == "size3"
                ? PosTextSize.size3
                : fontSizeTotal == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
          )),
    ]);
    if (dataTransaction.paymentMethod == null) {
      bytes += generator.row([
        PosColumn(
            text: "Bayar",
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
        PosColumn(
            text:
            "${formatCurrency.format(int.tryParse(dataTransaction.transactionpay ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
      ]);
      bytes += generator.row([
        PosColumn(
            text: "change".tr,
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
        PosColumn(
            text:
            "${formatCurrency.format(int.tryParse(dataTransaction.transactionreceived ?? "0"))}",
            width: 6,
            styles: PosStyles(
              align: PosAlign.right,
              fontType:  groupValueFontTypeTotal==1 ?   PosFontType.fontA :   PosFontType.fontB,
              height: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeTotal == "size4"
                  ? PosTextSize.size4
                  : fontSizeTotal == "size3"
                  ? PosTextSize.size3
                  : fontSizeTotal == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
            )),
      ]);
    }
    var footer;
    if (box.hasData(MyString.FOOTER_TEXT)) {
      footer = box.read(MyString.FOOTER_TEXT);
    } else {
      footer = "Terima Kasih berbelanja";
      box.write(MyString.FOOTER_TEXT, footer);
    }

    if (printCopy)
      bytes += generator.text('+++++++Salinan+++++++',
          styles: PosStyles(
              align: PosAlign.center,
              fontType: groupValueFontTypeFooter == 1
                  ? PosFontType.fontA
                  : PosFontType.fontB,
              height: fontSizeFooter == "size4"
                  ? PosTextSize.size4
                  : fontSizeFooter == "size3"
                  ? PosTextSize.size3
                  : fontSizeFooter == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              width: fontSizeFooter == "size4"
                  ? PosTextSize.size4
                  : fontSizeFooter == "size3"
                  ? PosTextSize.size3
                  : fontSizeFooter == "size2"
                  ? PosTextSize.size2
                  : PosTextSize.size1,
              bold: true));
    bytes += generator.text(box.read(MyString.FOOTER_TEXT),
        styles: PosStyles(
            align: PosAlign.center,
            fontType: groupValueFontTypeFooter == 1
                ? PosFontType.fontA
                : PosFontType.fontB,
            height: fontSizeFooter == "size4"
                ? PosTextSize.size4
                : fontSizeFooter == "size3"
                ? PosTextSize.size3
                : fontSizeFooter == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            width: fontSizeFooter == "size4"
                ? PosTextSize.size4
                : fontSizeFooter == "size3"
                ? PosTextSize.size3
                : fontSizeFooter == "size2"
                ? PosTextSize.size2
                : PosTextSize.size1,
            bold: true));
    bytes += generator.text("Powered by DPOS",
        styles: PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    bytes += generator.drawer();
    bytes += generator.cut();
    return bytes;
  }
  void printTicketPurchaseReport(ReportTransaction reportTransaction,
      {var startDate, var endDate, var type = "sales"}) async {
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (result) {
      // loadingBuilder();
      bool printTest = true;

      await PrintBluetoothThermal.disconnect;
      if (box.read(MyString.PRINTER_TYPE) == "bluetooth") {
        bool? isConnected = await PrintBluetoothThermal.connectionStatus;
        if (isConnected) {
          List<int> bytes = await getTicketPurchaseReport(
              reportTransaction: reportTransaction,
              startDate: startDate,
              endDate: endDate,
              type: type);
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        } else {
          var a = await PrintBluetoothThermal.connect(
                  macPrinterAddress: box.read(MyString.DEFAULT_PRINTER))
              .then((value) {
            if (value)
              printTest = true;
            else
              printTest = false;
          });
          List<int> bytes = await getTicketPurchaseReport(
              reportTransaction: reportTransaction,
              startDate: startDate,
              endDate: endDate,
              type: type);
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        }
      }

      // Get.back();
      if (printTest) {
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            message: "Printing Success",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            message: "Printing Gagal! Periksa Bluetooth di kedua device anda",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      }
    } else {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Bluetooth Anda tidak Aktif",
          title: "Print");
      var controller = Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());

      if (controller.isInterstitialAdReady)
        Future.delayed(Duration(seconds: 2), () {
          controller.interstitialAd.show();
        });
    }
  }


  void printTicketPurchaseReportUSB(ReportTransaction reportTransaction,
      {var startDate, var endDate, var type = "sales"}) async {
    usb.USBPrinter printUSB=usb.USBPrinter(
        id:box.read("printerID"),
        type:box.read("type"),
        name:box.read("printerName"),
        address: box.read("address"),
        deviceId: box.read("deviceId"),
        vendorId: box.read("vendorId"),
        productId:box.read("productId"),
        connected:box.read("connected"),
        connectionType:box.read("ConnectionType")=="ConnectionType.usb" ? ConnectionType.usb : ConnectionType.usb
    );

    connect(printUSB);
    // List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    // final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = await getTicketPurchaseReport(
        reportTransaction: reportTransaction,type: type,endDate: endDate,startDate: startDate);

    print("asdadasdasd");
    if (managerUSB != null) {
      print("isConnected ${managerUSB!.isConnected}");
      managerUSB!.writeBytes(bytes, isDisconnect: false);
    }
  }




  Future<List<int>> getTicketPurchaseReport(
      {required ReportTransaction reportTransaction,
      var startDate,
      var endDate,
      String type = "sales"}) async {
    var auth = AuthSessionManager();
    List<int> bytes = [];
    print(box.read(MyString.PRINTER_PAPER));
    CapabilityProfile profile = await CapabilityProfile.load();

    final generator;
    if (box.read(MyString.PRINTER_PAPER) == "80")
      generator = Generator(PaperSize.mm80, profile);
    else
      generator = Generator(PaperSize.mm58, profile);
    // bytes += generator.setGlobalCodeTable('ISO_8859-15');

    bytes += generator.setGlobalFont(PosFontType.fontB);

// print(dir);

//
  if(GetPlatform.isAndroid){
    if (invoiceC.logo.value) {
      File file = new File(box.read(MyString.BUSINESS_LOGO));

      final Uint8List imgBytes = file.readAsBytesSync();
      final Image image = decodeImage(imgBytes)!;
      Image thumbnail = copyResize(image, width: 250, height: 150);

      bytes += generator.image(thumbnail);
    }
  }

    bytes += generator.text(auth.storeName,
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
        linesAfter: 0);

    bytes += generator.text(
        box.read(MyString.STORE_ADDRESS) == null
            ? "-"
            : box.read(MyString.STORE_ADDRESS),
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Whatsapp: ${box.read(MyString.BUSINESS_CONTACT)}',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Laporan Penjulan',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text("${startDate} - ${endDate}",
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.hr();
    bytes += generator.text(
        "Tgl ctk : ${DateFormat('EEE, dd MMM yyyy HH:mm:ss', "${Get.locale}").format(DateTime.now())}",
        styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Kasir : ${auth.userFullName}',
        styles: PosStyles(align: PosAlign.left));
    bytes += generator.hr();
    int total = 0;
    if (type == "sales") {
      reportTransaction.data!.penjualanProduk!.forEach((item) {
        total += int.tryParse(item.sum.toString())!;
        bytes += generator.row([
          PosColumn(
              text: item.name!,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: item.count.toString(),
              width: 2,
              styles:
                  PosStyles(align: PosAlign.center, height: PosTextSize.size1)),
          PosColumn(
              text: "${formatCurrency.format(item.sum)}",
              width: 4,
              styles:
                  PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
        ]);
      });

      bytes += generator.row([
        PosColumn(
            text: "Jumlah",
            width: 6,
            styles: PosStyles(
                align: PosAlign.left,
                width: PosTextSize.size1,
                height: PosTextSize.size1)),
        PosColumn(
            text: "${formatCurrency.format(total)}",
            width: 6,
            styles:
                PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
      ]);
    } else {
      reportTransaction.data!.paymentMethod!.forEach((item) {
        // total += int.tryParse(item.total.toString())!;
        bytes += generator.row([
          PosColumn(
              text: item.paymentMethodAlias!,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: item.count.toString(),
              width: 2,
              styles:
                  PosStyles(align: PosAlign.center, height: PosTextSize.size1)),
          PosColumn(
              text: "${formatCurrency.format(item.total)}",
              width: 4,
              styles:
                  PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
        ]);
      });

      bytes += generator.row([
        PosColumn(
            text: "Jumlah",
            width: 6,
            styles: PosStyles(
                align: PosAlign.left,
                width: PosTextSize.size1,
                height: PosTextSize.size1)),
        PosColumn(
            text: "${formatCurrency.format(total)}",
            width: 6,
            styles:
                PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
      ]);
    }

    bytes += generator.hr();

    bytes += generator.text("Powered by DPOS",
        styles: PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    bytes += generator.drawer();
    bytes += generator.cut();
    return bytes;
  }

  Future<List<int>> getTicketPurchaseReportByCategory(
      {required ReportTransactionByCategory reportTransaction,
        var startDate,
        var endDate}) async {
    var auth = AuthSessionManager();
    List<int> bytes = [];
    print(box.read(MyString.PRINTER_PAPER));
    CapabilityProfile profile = await CapabilityProfile.load();

    final generator;
    if (box.read(MyString.PRINTER_PAPER) == "80")
      generator = Generator(PaperSize.mm80, profile);
    else
      generator = Generator(PaperSize.mm58, profile);
    // bytes += generator.setGlobalCodeTable('ISO_8859-15');

    bytes += generator.setGlobalFont(PosFontType.fontB);

// print(dir);

//
  if(GetPlatform.isAndroid){
    if (invoiceC.logo.value) {
      File file = new File(box.read(MyString.BUSINESS_LOGO));

      final Uint8List imgBytes = file.readAsBytesSync();
      final Image image = decodeImage(imgBytes)!;
      Image thumbnail = copyResize(image, width: 250, height: 150);

      bytes += generator.image(thumbnail);
    }
  }

    bytes += generator.text(auth.storeName,
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
        linesAfter: 0);

    bytes += generator.text(
        box.read(MyString.STORE_ADDRESS) == null
            ? "-"
            : box.read(MyString.STORE_ADDRESS),
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Whatsapp: ${box.read(MyString.BUSINESS_CONTACT)}',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Laporan Penjulan',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text("${startDate} - ${endDate}",
        styles: PosStyles(align: PosAlign.center));

    bytes += generator.hr();
    bytes += generator.text(
        "Tgl ctk : ${DateFormat('EEE, dd MMM yyyy HH:mm:ss', "${Get.locale}").format(DateTime.now())}",
        styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Kasir : ${auth.userFullName}',
        styles: PosStyles(align: PosAlign.left));
    bytes += generator.hr();
    int total = 0;

      reportTransaction.data!.forEach((item) {
        total += int.tryParse(item.sum.toString())!;
        bytes += generator.row([
          PosColumn(
              text: item.name!,
              width: 6,
              styles: PosStyles(
                align: PosAlign.left,
              )),
          PosColumn(
              text: item.count.toString(),
              width: 2,
              styles:
              PosStyles(align: PosAlign.center, height: PosTextSize.size1)),
          PosColumn(
              text: "${formatCurrency.format(item.sum)}",
              width: 4,
              styles:
              PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
        ]);
      });

      bytes += generator.row([
        PosColumn(
            text: "Jumlah",
            width: 6,
            styles: PosStyles(
                align: PosAlign.left,
                width: PosTextSize.size1,
                height: PosTextSize.size1)),
        PosColumn(
            text: "${formatCurrency.format(total)}",
            width: 6,
            styles:
            PosStyles(align: PosAlign.right, height: PosTextSize.size1)),
      ]);


    bytes += generator.hr();

    bytes += generator.text("Power By DPOS",
        styles: PosStyles(
            align: PosAlign.center, fontType: PosFontType.fontA, bold: true));
    bytes += generator.drawer();
    bytes += generator.cut();
    return bytes;
  }



  void printTicketPurchaseReportByCategory(ReportTransactionByCategory reportTransaction,
      {var startDate, var endDate}) async {
    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    if (result) {
      // loadingBuilder();
      bool printTest = true;

      await PrintBluetoothThermal.disconnect;
      if (box.read(MyString.PRINTER_TYPE) == "bluetooth") {
        bool? isConnected = await PrintBluetoothThermal.connectionStatus;
        if (isConnected) {
          List<int> bytes = await getTicketPurchaseReportByCategory(
              reportTransaction: reportTransaction,
              startDate: startDate,
              endDate: endDate);
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        } else {
          var a = await PrintBluetoothThermal.connect(
              macPrinterAddress: box.read(MyString.DEFAULT_PRINTER))
              .then((value) {
            if (value)
              printTest = true;
            else
              printTest = false;
          });
          List<int> bytes = await getTicketPurchaseReportByCategory(
              reportTransaction: reportTransaction,
              startDate: startDate,
              endDate: endDate,
              );
          final result = await PrintBluetoothThermal.writeBytes(bytes);
        }
      }

      // Get.back();
      if (printTest) {
        showSnackBar(
            snackBarType: SnackBarType.SUCCESS,
            message: "Printing Success",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      } else {
        showSnackBar(
            snackBarType: SnackBarType.ERROR,
            message: "Printing Gagal! Periksa Bluetooth di kedua device anda",
            title: "Print");
        var controller = Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController());

        if (controller.isInterstitialAdReady)
          Future.delayed(Duration(seconds: 2), () {
            controller.interstitialAd.show();
          });
      }
    } else {
      showSnackBar(
          snackBarType: SnackBarType.INFO,
          message: "Bluetooth Anda tidak Aktif",
          title: "Print");
      var controller = Get.isRegistered<TransactionController>()
          ? Get.find<TransactionController>()
          : Get.put(TransactionController());

      if (controller.isInterstitialAdReady)
        Future.delayed(Duration(seconds: 2), () {
          controller.interstitialAd.show();
        });
    }
  }

  void printTicketPurchaseReportByCategoryUSB(ReportTransactionByCategory reportTransaction,
      {var startDate, var endDate}) async {
    usb.USBPrinter printUSB=usb.USBPrinter(
        id:box.read("printerID"),
        type:box.read("type"),
        name:box.read("printerName"),
        address: box.read("address"),
        deviceId: box.read("deviceId"),
        vendorId: box.read("vendorId"),
        productId:box.read("productId"),
        connected:box.read("connected"),
        connectionType:box.read("ConnectionType")=="ConnectionType.usb" ? ConnectionType.usb : ConnectionType.usb
    );

    connect(printUSB);
    // List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    // final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = await getTicketPurchaseReportByCategory(
        reportTransaction: reportTransaction,endDate: endDate,startDate: startDate);

    print("asdadasdasd");
    if (managerUSB != null) {
      print("isConnected ${managerUSB!.isConnected}");
      managerUSB!.writeBytes(bytes, isDisconnect: false);
    }
  }
























   contentWeb(){
    var html;
    List aa=['aaa','ggg'];
    var bb;
    bb=""" """;
    aa.forEach((element) {
      bb+="""$element """;
    });
    html= """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECEIPT</title>
</head>

<style>
    body,
    p {
        margin: 0px;
        padding: 0px;
    }

    body {
        background: #eee;
        width: 576px;
        font-size: 1.8em
    }

    .receipt {
        max-width: 576px;
        margin: auto;
        background: white;
    }

    .container {
        padding: 5px 15px;
    }

    hr {
        border-top: 2px dashed black;
    }

    .text-center {
        text-align: center;
    }

    .text-left {
        text-align: left;
    }

    .text-right {
        text-align: left;
    }

    .text-justify {
        text-align: justify;
    }

    .right {
        float: right;
    }

    .left {
        float: left;
    }

    .total {
        font-size: 2.5em;
        margin: 5px;
    }

    a {
        color: #1976d2;
    }

    span {
        color: black;
    }

    .full-width {
        width: 100%;
    }

    .inline-block {
        display: inline-block;
    }
</style>

<body>

    <div class="receipt">
        <div class="container">
            <!-- header part -->
            <div class="text-center">
                <p>MYLEKHA STORE</p>
                <hr>
                <p class="total">320.00</p>
                <span>Total</span>
            </div>
            <hr>
            <!-- end header part -->

            <p>Cashier: owner</p>
            <p>POS: POS 1</p>
            <hr>
            <!-- product part -->
            <p style="display: flex; justify-content:  space-between; align-items: center;">
                <b>Total</b>
                <b>4.00</b>
            </p>
            <p style="display: flex; justify-content:  space-between; align-items: center;">
                <b>Total</b>
                <b>4.00</b>
            </p>
            <p style="display: flex; justify-content:  space-between; align-items: center;">
                <b>Total</b>
                <b>4.00</b>
            </p>
            <p style="display: flex; justify-content:  space-between; align-items: center;">
                <b>Total</b>
                <b>4.00</b>
            </p>
            <p style="display: flex; justify-content:  space-between; align-items: center;">
                <b>Total</b>
                <b>4.00</b>
            </p>


            $bb
            <hr>
            <!-- end product part -->

            <!-- footer part -->
            <p class="full-width inline-block">
                <b class="left">Total</b>
                <b class="right">4.00</b>
            </p>
            <p class="full-width inline-block">
                <b class="left">Cash</b>
                <b class="right">4.00</b>
            </p>
        </div>
        <hr>
        <!-- end footer part -->
        <div class="container">
            <p class="full-width inline-block">
                <span class="left">01/09/2020 22:23</span>
                <span class="right">No 3-10001</span>
            </p>
        </div>

    </div>
    <div class="container text-center">
        <br>
        <p>សូមអរគុណ</p>
        <p>@2020 <a href="https://mylekha.app">MYLEKHA</a>. All right reserved.</p>
    </div>
    <br>
    <br>


</body>

</html>
  """;

    return html;
  }


}
