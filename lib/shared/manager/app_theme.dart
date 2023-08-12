import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

   final lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
       // primarySwatch: primaryColor,
      iconTheme:IconThemeData(
        color: primaryColor
      ) ,
      primaryColor: primaryColor,
      primarySwatch: primaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color:Colors.black ),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent,
              statusBarIconBrightness:Brightness.dark,
          systemNavigationBarColor:Colors.transparent ),
      ),
      textTheme: TextTheme(

          labelLarge: TextStyle(color: Colors.red)),
       // colorScheme: ColorScheme(background: lightBackgroundColor)
   );

   final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    primaryColor: primaryColor,
    backgroundColor: darkBackgroundColor,
    scaffoldBackgroundColor: const Color(0xFF00040F),
    visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color:Colors.white ),
        backgroundColor: Colors.transparent,systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:Brightness.light,systemNavigationBarColor:Colors.transparent)
      ),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: darkTextColor),
    ),

  );



extension ThemeExtras on ThemeData {

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  Color get baseColor => brightness == Brightness.light
      ?  Colors.grey[350]!:Colors.white60;
  Color get highlightColor => brightness == Brightness.light
      ?  Colors.grey[100]!:Colors.grey[100]!;

  Color get textColor1 => brightness == Brightness.light
      ?  Colors.grey
      : Colors.white24;
  Color get textColor2 => brightness == Brightness.light
      ?  Colors.black
      : Colors.white;
  Color get textColor3 => brightness == Brightness.light
      ?  Colors.grey
      : Colors.white;

  Color get shadow => brightness == Brightness.light
      ?  Color.fromARGB(76, 0, 0, 0)
      : Colors.white70;
  Color get shadowSk => brightness == Brightness.light
      ? Colors.grey.shade300
      : Colors.white70;
//theme
  String get textTh => brightness == Brightness.dark
      ?  "Dark Mode": "Light Mode";
  IconData get iconTh => brightness == Brightness.dark
      ?   Icons.dark_mode_outlined: Icons.light_mode;
  Color get iconCo => brightness == Brightness.dark
      ?   primaryColor: Colors.grey;
  bool get boolTh => brightness == Brightness.light
      ?   true: false;
//color

}
