




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmi/core/globals/global_color.dart';
// Normal
TextStyle whiteTextFont = GoogleFonts.droidSans()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blackTextFont = GoogleFonts.droidSans()
    .copyWith(color: Colors.black,);
TextStyle pColorTextFont = GoogleFonts.droidSans()
    .copyWith(color: MyColor.colorOrangeDark, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.droidSans()
    .copyWith(color: Colors.grey[400], fontWeight: FontWeight.w500);
// bold -> title
TextStyle whiteTextTitle = GoogleFonts.roboto()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blackTextTitle = GoogleFonts.roboto()
    .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
TextStyle pColorTextTitle = GoogleFonts.roboto()
    .copyWith(color: MyColor.colorOrangeDark, fontWeight: FontWeight.w500);
TextStyle greyTextTitle = GoogleFonts.roboto()
    .copyWith(color: Colors.grey[400], fontWeight: FontWeight.w500);
