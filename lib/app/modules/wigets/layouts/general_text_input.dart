import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/core/globals/global_color.dart';

class GeneralTextInput extends StatelessWidget {
  final String labelTextInputBox;
  final String descTextInputBox;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final double paddingBottom;
  final double borderRadius;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int maxLines;
  final bool autoFocus;
  final VoidCallback? onClick;

  const GeneralTextInput(
      {Key? key,
      required this.labelTextInputBox,
      required this.descTextInputBox,
      this.controller,
      this.paddingBottom = 20.0,
      this.keyboardType,
      this.readOnly = false,
      this.textInputAction = TextInputAction.next, this.borderRadius=25, this.maxLines=1, this.onClick, this.autoFocus=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onTap: onClick,
            textInputAction: textInputAction,
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            maxLines: maxLines,
            autofocus: autoFocus,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              border: OutlineInputBorder(
                borderSide:
                const BorderSide(color: MyColor.colorPrimary, width: 2.0),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              hintText: "$labelTextInputBox",

            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          Text(
            "   * $descTextInputBox",
            style: GoogleFonts.droidSans(
                fontStyle: FontStyle.italic, color: MyColor.colorBlackT50,fontSize: 12),
          ),
          // SizedBox(
          //   height: paddingBottom,
          // ),
        ],
      ),
    );
  }
}
