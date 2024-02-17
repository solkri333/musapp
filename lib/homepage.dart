// import 'dart:html';

import 'package:flutter/material.dart';
import 'Primary.dart';
import 'spam.dart';
import 'important.dart';
import 'starred.dart';
// import 'header.dart';
//import 'messages.dart';

Map<String, Color> colorPalettee = {
  'primary': Color.fromARGB(255, 25, 136, 255),
  'secondary': const Color(0xFFF5A623),
  'accent': Color.fromARGB(255, 145, 42, 77),
  'text': const Color(0xFF333333),
  'background': const Color(0xFFFFFFFF),
};

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  bool click = true;
  Icon icon1 = const Icon(Icons.linear_scale);
  Icon icon2 = const Icon(Icons.linear_scale_rounded);
  Icon icon = const Icon(Icons.linear_scale);

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (index) {
      case 0:
        page = const MyPrimary();
        break;
      case 1:
        page = const ImportantPage();
        break;
      case 2:
        page = const StarredPage();
        break;
      case 3:
        page = const SpamPage();
        break;
      default:
        throw UnimplementedError('no widget for $index');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xFF4E0028),
          //   // title: Text(
          //   //   "SB",
          //   //   style: TextStyle(
          //   //       fontWeight: FontWeight.bold, color: Color(0xFF002411)),
          //   // ),
          //   leading: InkWell(
          //     child: Icon(Icons.radio_button_off_sharp),
          //     onTap: () {},
          //   ),
          // ),
          body: Row(
        children: [
          SafeArea(
            child: navigationRail(),
          ),
          Expanded(
              child: Container(
            child: page,
          ))
        ],
      ));
    });
  }

  NavigationRail navigationRail() {
    return NavigationRail(
      // ignore: deprecated_member_use
      //indicatorColor: colorPalettee['secondary'],
      selectedLabelTextStyle: const TextStyle(
          // color: colorPalettee[""],
          color: Color.fromARGB(255, 0, 40, 198),
          // color: Color.fromARGB(255, 237, 150, 11),
          fontWeight: FontWeight.bold),
      // backgroundColor: colorPalettee['background'],
      // backgroundColor: colorPalettee["primary"],
      backgroundColor: Color.fromARGB(255, 27, 159, 93),
      selectedIconTheme: IconThemeData(color: colorPalettee["secondary"]),
      //const IconThemeData(color: Color.fromARGB(255, 28, 127, 181)),
      unselectedIconTheme: const IconThemeData(color: Color(0xFF333333)),
      //const IconThemeData(
      //  color: Color.fromARGB(208, 5, 71, 106), opacity: 70),
      leading: IconButton(
          onPressed: () {
            setState(() {
              click = !click;
              if (icon == icon1) {
                setState(() {
                  icon = icon2;
                });
              } else {
                setState(() {
                  icon = icon1;
                });
              }
            });
          },
          icon: icon),

      extended: click,
      destinations: const [
        NavigationRailDestination(
            icon: Icon(Icons.inbox), label: Text("Inbox")),
        NavigationRailDestination(
            icon: Icon(Icons.label_important), label: Text("Important")),
        NavigationRailDestination(
            icon: Icon(Icons.favorite_outlined), label: Text("Favourites")),
        NavigationRailDestination(
            icon: Icon(Icons.report), label: Text("Spam")),
      ],
      selectedIndex: index,
      onDestinationSelected: (value) {
        setState(() {
          index = value;
        });
      },
    );
  }
}
