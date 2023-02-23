import 'package:flutter/material.dart';
import 'pages/HomePage/HomePageScaffold.dart';
import 'pages/BottomNavigationBarPage.dart';
import 'pages/helpers/InternetHelper.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  final LightTheme = ThemeData(
    //appbar
    primaryColor: Color(0xFFFFC491),  //PEACH BLUSH (ok)
    //scaffoldBackground
    scaffoldBackgroundColor: Color(0xFFEBE7E1),  //CREAMY SMOKE
    //ScrollBar
    highlightColor: Colors.white10,
    //ListView上下水波紋
    //accentColor: Color(0xFFEBE7E1),
  );

  InternetHelper internetHelper = InternetHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LightTheme,
      home: BottomNavigationBarPage(),



    );
  }
}
