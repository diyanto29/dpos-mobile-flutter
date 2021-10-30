
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmi/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class BottomDialogContact extends StatelessWidget {
  const BottomDialogContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TransactionController>();

    return GetBuilder<TransactionController>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(title: Text("list Kontak"),),
        body:  Container(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColor.colorWhite),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 5.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              // logic.listContact.length==0 ? Center(
              //   child: CircularProgressIndicator(),
              // ):
              // ListView.builder(
              //     itemCount: controller.listContact.length,
              //     physics: ClampingScrollPhysics(),
              //     shrinkWrap: true,
              //     itemBuilder: (c, i) {
              //       Contact contact = controller.listContact[i];
              //       return Card(
              //         child: ListTile(
              //           onTap: () {
              //             controller.selectedContact(contact);
              //
              //             Get.back();
              //           },
              //           leading: (controller.listContact[i].avatar !=
              //               null &&
              //               controller.listContact[i].avatar!.length > 0)
              //               ? CircleAvatar(
              //             backgroundImage: MemoryImage(
              //                 contact.avatar!),
              //           )
              //               : CircleAvatar(
              //             child: Text(
              //                 controller.listContact[i].initials()),
              //           ),
              //           title: Text("${contact.displayName==null ? '-' :contact.displayName! }"),
              //           subtitle: Text(contact.phones!.length > 0
              //               ? contact.phones!
              //               .elementAt(0)
              //               .value!
              //               : ""),
              //         ),
              //       );
              //     })
            ],
          ),
        ),
      );
    });
  }
}
