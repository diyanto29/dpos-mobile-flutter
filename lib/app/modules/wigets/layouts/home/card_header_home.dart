import 'package:flutter/material.dart';
import 'package:warmi/core/utils/thema.dart';

class CardHeaderHome extends StatelessWidget {
  final String? imgUrl;
  final String? textCard;
  final Color colorBackground;

  const CardHeaderHome({Key? key, this.imgUrl, this.textCard,required this.colorBackground}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      flex: 2,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 375),
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("${imgUrl}",),
            SizedBox(width: 10,),
            Text("${textCard}",style: blackTextTitle,)

          ],
        ),
      ),
    );
  }
}
