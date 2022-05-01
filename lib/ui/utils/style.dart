import 'package:flutter/material.dart';

class Style {
  // colors
  static final Color primaryColor =
      Color.fromARGB(255, 42, 129, 211); // #EBC25C
  static final Color darkColor = Color(0xFF252525); // #252525
  static final Color cardColor = Color(0xFF3D3D3D); // #3D3D3D
  static final Color placeHolderColor = Colors.grey; // #8C8C8C

  // text style
  static TextStyle defaultTextStyle =
      TextStyle(color: darkColor, fontFamily: 'Montserrat', fontSize: 14);
  static TextStyle titleTextStyle =
      TextStyle(color: darkColor, fontFamily: 'Montserrat', fontSize: 14);
  static TextStyle boldTitleTextStyle =
      TextStyle(color: darkColor, fontWeight: FontWeight.w700, fontSize: 31);
  static TextStyle largeTitleTextStyle =
      TextStyle(color: darkColor, fontWeight: FontWeight.w600, fontSize: 17);
  static TextStyle regularTitleTextStyle =
      TextStyle(color: darkColor, fontWeight: FontWeight.w500, fontSize: 14);

  // box decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [BoxShadow(color: cardColor)],
    borderRadius: BorderRadius.circular(8),
  );
  static BoxDecoration outlineCardDecoration = BoxDecoration(
      color: darkColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: cardColor, width: 2));
}
