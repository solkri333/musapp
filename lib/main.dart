import 'dart:convert';

import 'package:flutter/material.dart';
import 'homepage.dart';
// import 'Primary.dart';
// import 'spam.dart';
// import 'important.dart';
// import 'starred.dart';
//import 'messages.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'dart:io';
import 'login.dart';
import 'package:http/http.dart' as http;

Widget widget = const LoginPage();
void main() async {
  if (await checkAccount()) {
    widget = const MyHomePage();
  } else {
    widget = const LoginPage();
  }
  runApp(MyApp());
}

// const FlexSchemeData customFlexScheme = FlexSchemeData(
//   name: 'Toledo purple',
//   description: 'Purple theme created from custom defined colors.',
//   light: FlexSchemeColor(
//     primary: Color(0xFF4E0028),
//     primaryVariant: Color(0xFF320019),
//     secondary: Color(0xFF003419),
//     secondaryVariant: Color(0xFF002411),
//   ),
//   dark: FlexSchemeColor(
//     primary: Color.fromARGB(255, 160, 85, 124),
//     primaryVariant: Color(0xFF775C69),
//     secondary: Color(0xFF738F81),
//     secondaryVariant: Color(0xFF5C7267),
//   ),
// );

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<String, Color> colorPalette = {
    "primary": const Color(0xFF007AFF), //(bright blue)
    "secondary": const Color(0xFF3B3B3B), //(dark grey)
    "accent_1": const Color(0xFF4AC9FF), //(light blue)
    "accent_2": const Color(0xFFFF3B30), //(red)
    "accent_3": const Color(0xFFFF9500), //(orange)
  };

  Map<String, Color> colorPalettee = {
    'primary': const Color(0xFF527DAA),
    'secondary': const Color(0xFFF5A623),
    'accent': const Color(0xFFE91E63),
    'text': const Color(0xFF333333),
    'background': const Color(0xFFFFFFFF),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // The color scheme for the dark theme, made toTheme
      // darkTheme: FlexColorScheme.dark(
      //   colors: customFlexScheme.dark,
      //   visualDensity: FlexColorScheme.comfortablePlatformDensity,
      // ).toTheme,
      theme: ThemeData(
        primaryColor: colorPalette['primary'],
        // ignore: deprecated_member_use
        // hintColor: colorPalette['accent_2']
      ),

      home: widget,
    );
  }
}

/*color: 0xFF1F1F1F
0xFF656EA4
0xFFD0B3CA
0xFF157F1F*/

/*alternative: 0xFF47313C
0xFF7167C4
0xFFD0B2D1
0xFF198B87*/

Future<bool> checkAccount() async {
  final response =
      await http.post(Uri.parse("http://127.0.0.1:5000/checkAccount"));
  final decoded = json.decode(response.body);
  if (decoded['statusCode'] == 200) {
    return true;
  } else {
    return false;
  }
}
