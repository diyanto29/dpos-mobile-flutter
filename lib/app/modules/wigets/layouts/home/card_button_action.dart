import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/utils/thema.dart';
class CardButtonAction extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? colorBackground;
  final String icon;
  final String? labelIcon;
  const CardButtonAction({Key? key, required this.onPressed,  this.colorBackground, required this.icon, this.labelIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 8.h,
      width: 1.w,

      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onPressed,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: colorBackground
                ),
                child: Image.asset("${icon}")),
            SizedBox(height: 3,),
            labelIcon!.isEmpty ? Container(): Expanded(child: Text("${labelIcon}",style: blackTextFont.copyWith(fontSize: 14.sp),))
          ],
        ),
      ),
    );
  }
}
