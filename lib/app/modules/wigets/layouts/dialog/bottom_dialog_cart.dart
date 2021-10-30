import 'package:flutter/material.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:warmi/core/globals/global_string.dart';

class BottomDialogCart extends StatefulWidget {
  const BottomDialogCart({Key? key}) : super(key: key);

  @override
  _BottomDialogCartState createState() => _BottomDialogCartState();
}

class _BottomDialogCartState extends State<BottomDialogCart> {
  @override
  Widget build(BuildContext context) {
    var groupValue;
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.4,
      initialChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(MyString.DEFAULT_PADDING),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColor.colorWhite),
          child: ListView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  height: 5.0,
                  width: 70.0,
                  decoration: BoxDecoration(
                      color: Colors.grey[400], borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              ListView.builder(
                  itemCount: 3,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c, i) {
                    return RadioListTile(
                        value: 'Toko Barokah',

                        selected: true,
                        groupValue: groupValue,
                        onChanged: (v) {},
                    title: Text("Toko Barokah"),);
                  })
            ],
          ),
        );
      },
    );
  }
}
