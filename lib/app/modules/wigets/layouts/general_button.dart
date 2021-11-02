import 'package:flutter/material.dart';
import 'package:warmi/core/globals/global_color.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:warmi/core/utils/thema.dart';

class GeneralButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final double? fontSize;
  final double? borderRadius;

  const GeneralButton({Key? key, required this.label, required this.onPressed, this.height=54, this.width=double.infinity, this.color=MyColor.colorPrimary, this.fontSize, this.borderRadius=10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!))),
            child: Text("${label}",style: whiteTextTitle.copyWith(fontSize: fontSize),)));
  }
}
