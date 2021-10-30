
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/core/globals/global_color.dart';

class MenuActionButton extends StatelessWidget {
  final VoidCallback onClick;
  final dynamic icon;
  final double sizeIcon;
  final String textButton;
  final double sizeTextButton;
  final bool subtitle;
  final String? textSubtitle;
  final bool? trailing;
  final bool? statusIcon;
  final bool? axisSpacing;
  final double borderRadius;

  const MenuActionButton(
      {Key? key,
        required this.onClick,
        required this.icon,
        this.sizeIcon = 25,
        required this.textButton,
        this.sizeTextButton = 14, this.subtitle=false, this.textSubtitle, this.trailing=true, this.statusIcon=true, this.borderRadius=0.0, this.axisSpacing=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      splashColor: Colors.white,
      child: Padding(
        padding: axisSpacing! ? EdgeInsets.fromLTRB(0, 5, 8, 5) : EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.colorWhite,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow:axisSpacing! ? [
              BoxShadow(
                color: MyColor.colorBlackT50,offset: Offset(0,1)
              )
            ]:[]
          ),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    statusIcon! ? Image.asset(
                      "$icon",
                      height: sizeIcon,
                      fit: BoxFit.contain,
                    ) : Container(),
                    SizedBox(
                      width: 10,
                    ),
                    subtitle ? Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$textButton",
                            style: GoogleFonts.poppins(
                                letterSpacing: 1, fontSize: sizeTextButton,fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(height: 5,),
                          Text(
                            "$textSubtitle",
                            style: GoogleFonts.poppins(
                                 fontSize: 12,color: MyColor.colorBlack),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ) : Text(
                      "$textButton",
                      style: GoogleFonts.poppins(
                          letterSpacing: 1, fontSize: sizeTextButton),
                    ),
                  ],
                ),
              ),
              trailing! ?   Flexible(
                flex: 1,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 17,
                  color: MyColor.colorPrimary,
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
