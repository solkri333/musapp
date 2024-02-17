import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'header.dart';
import 'MessageGesture.dart';
import 'messageFetcher.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
// import 'dart:core';

// class MyPrimaryPage extends StatefulWidget {
//   const MyPrimaryPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyPrimaryPage createState() => _MyPrimaryPage();
// }

// class _MyPrimaryPage extends State<MyPrimaryPage> {
//   late List<String> _senderList;
//   late List<String> _subjectList;

//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }

//   Future<void> fetchMessages() async {
//     final response = await http.get(Uri.parse('http://127.0.0.1:5000/'));
//     final decoded = json.decode(response.body);
//     setState(() {
//       _senderList = List<String>.from(decoded['Sender']);
//       _subjectList = List<String>.from(decoded['Subject']);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _senderList != null && _subjectList != null
//           ? StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState) {
//                 return PrimaryPage(
//                   senderList: _senderList,
//                   subjectList: _subjectList,
//                 );
//               },
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// class PrimaryPage extends StatelessWidget {
//   final List<String> senderList;
//   final List<String> subjectList;

//   const PrimaryPage({
//     Key? key,
//     required this.senderList,
//     required this.subjectList,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         shadowColor: Colors.grey,
//         backgroundColor: Color.fromARGB(255, 174, 24, 74),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 20.0),
//             child: Row(
//               children: const [
//                 Text(
//                   "Inbox",
//                   style: TextStyle(
//                       color: Color(0xFFE91E63),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(6),
//                     topRight: Radius.circular(6),
//                   ),
//                 ),
//                 child: ListView.builder(
//                   itemCount: senderList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return MessageGesture(
//                       emailaddress: senderList[index],
//                       subject: subjectList[index],
//                       shadowcolor: 0xFF6AB837,
//                     );
//                   },
//                   controller: ScrollController(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//old class
// class PrimaryPage extends StatefulWidget {
//   const PrimaryPage({Key? key}) : super(key: key);

//   @override
//   State<PrimaryPage> createState() => _PrimaryPage();
// }

// class _PrimaryPage extends State<PrimaryPage> {
//   // Map<String, List>? primaryData;
//   late List<String> _senderList = [];
//   late List<String> _subjectList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchMessages();
//   }

//   Future<void> fetchMessages() async {
//     final response = await http.get(Uri.parse('http://127.0.0.1:5000/'));
//     final decoded = json.decode(response.body);
//     setState(() {
//       _senderList = List<String>.from(decoded['Sender']);
//       _subjectList = List<String>.from(decoded['Subject']);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         shadowColor: Colors.grey,
//         backgroundColor: Color.fromARGB(255, 174, 24, 74),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 20.0),
//             child: Row(
//               children: const [
//                 Text(
//                   "Inbox",
//                   style: TextStyle(
//                       color: Color(0xFFE91E63),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: (_senderList.isNotEmpty && _subjectList.isNotEmpty)
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 10.0),
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(6),
//                           topRight: Radius.circular(6),
//                         ),
//                       ),
//                       child: ListView.builder(
//                         itemCount: _senderList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return MessageGesture(
//                             emailaddress: _senderList[index],
//                             subject: _subjectList[index],
//                             shadowcolor: 0xFF6AB837,
//                           );
//                         },
//                         controller: ScrollController(),
//                       ),
//                     ),
//                   )
//                 : const Center(child: CircularProgressIndicator()),
//           ),
//         ],
//       ),
//     );
//   }
// }

//old
class MyPrimary extends StatefulWidget {
  const MyPrimary({super.key});

  @override
  State<MyPrimary> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyPrimary> {
  late Future<Map<String, List>> _future;
  MessageDisplay messageDisplay = const MessageDisplay();
  @override
  void initState() {
    super.initState();
    _future = messageDisplay.getPrimary();
  }

  // Future<Map<String, List>> getPrimary(
  //     {String url = 'http://127.0.0.1:5000/'}) async {
  //   final response = await http.get(Uri.parse(url));
  //   final decoded = json.decode(response.body);
  //   Map<String, List> subemails = {};
  //   subemails['Subject'] = decoded['Subject'];
  //   subemails['Sender'] = decoded['Sender'];
  //   return subemails;
  // }

//new start
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white70,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.grey,
          // backgroundColor: Colors.white70,
          backgroundColor: Color.fromARGB(255, 174, 24, 74),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20.0),
              child: Row(
                //padding: EdgeInsets.only(left: 50),
                children: const [
                  Text(
                    "Inbox",
                    style: TextStyle(
                        //backgroundColor: Colors.tealAccent,
                        color: Color(0xFFE91E63),
                        // decoration: TextDecoration.underline,
                        // decorationThickness: 2,
                        // decorationColor: Color(0xFF198B87),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _future,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, List>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List? sender = snapshot.data!['Sender'];
                    List? subject = snapshot.data!['Subject'];
                    List? payload = snapshot.data!['Payload'];
                    return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                            // color: Colors.grey.shade300,
                          ),
                          child: DynMouseScroll(
                            builder: (context, controller, physics) =>
                                ListView.builder(
                              controller: controller,
                              physics: physics,

                              itemCount: sender?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MessageGesture(
                                  emailaddress: sender?[index],
                                  subject: subject?[index],
                                  msg: payload?[index],
                                  shadowcolor: 0xFFE91E63,
                                );
                              },
                              // controller: ScrollController(),
                            ),
                          ),
                        ));
                  }
                },
              ),
            ),
          ],
        ));
  }
}

//             Expanded(
//               child: FutureBuilder(
//                 future: _future,
//                 builder: (BuildContext context,
//                     AsyncSnapshot<Map<String, List>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     List? sender = snapshot.data!['Sender'];
//                     List? subject = snapshot.data!['Subject'];
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 10.0),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(6),
//                             topRight: Radius.circular(6),
//                           ),
//                           // color: Colors.grey.shade300,
//                         ),
//                         child: ListView.builder(
//                           itemCount: sender?.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return MessageGesture(
//                               emailaddress: sender?[index],
//                               subject: subject?[index],
//                               shadowcolor: 0xFF6AB837,
//                             );
//                           },
//                           controller: ScrollController(),
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ));
//   }
// }



  // void initState() {
  //   super.initState();
  //   primaryData = getPrimary();
  // }

  // void getheader() async {
  //   var sub = await getPrimary();
  //   setState(() {
  //     subemail = sub;
  //   });
  // }

//   Widget build(BuildContext context) {
//     if (subemail.isEmpty) {
//       // return a loading indicator or something else while waiting for data
//       return CircularProgressIndicator();
//     } else {
//       // List<String> subject = subemail['Subject'];
//       // List<String> sender = subemail['Sender'];
//       subject = subemail['Subject'];
//       sender = subemail['Sender'];
//       return ListView.builder(
//         itemCount: sender.length,
//         itemBuilder: (BuildContext context, int index) {
//           return MessageGesture(
//               emailaddress: sender[index], subject: subject[index]);
//         },
//       );
//     }
//   }
// }

        // body: Column(
        //   children: [
        //     const Padding(
        //       padding: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "Inbox",
        //         style: TextStyle(
        //             //backgroundColor: Colors.tealAccent,
        //             color: Color.fromARGB(255, 160, 14, 63),
        //             // decoration: TextDecoration.underline,
        //             // decorationThickness: 2,
        //             // decorationColor: Color(0xFF198B87),
        //             fontWeight: FontWeight.bold,
        //             fontSize: 30),
        //       ),
        //     ),

            // Expanded(
            //   child: FutureBuilder(
            //       // future: primaryData == null
            //       //     ? getPrimary()
            //       //     : Future.value(primaryData),
            //       future: _future,
            //       builder: (BuildContext context,
            //           AsyncSnapshot<Map<String, List>> snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const Center(child: CircularProgressIndicator());
            //         } else if (snapshot.hasError) {
            //           return Center(child: Text('Error: ${snapshot.error}'));
            //         } else {
            //           List? sender = snapshot.data!['Sender'];
            //           List? subject = snapshot.data!['Subject'];

            //           return Padding(
            //             padding: const EdgeInsets.only(top: 10.0),
            //             child: Container(
            //               decoration: const BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(8),
            //                   topRight: Radius.circular(8),
            //                 ),
            //                 //color: Colors.grey.shade300,
            //               ),
            //               child: ListView.builder(
            //                 itemCount: sender?.length,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return MessageGesture(
            //                     emailaddress: sender?[index],
            //                     subject: subject?[index],
            //                   );
            //                 },
            //                 controller: ScrollController(),
            //               ),
            //             ),
            //           );
            //         }
            //       }

            //       //   ),
            //       // ],
            //       ),
            // ),

            //same but new




//         ],
//       ),
//     );
//   }
// }

//new end

    // getSubject();
    // getEmail();

    //getBody();
    // List subj = [];
    // subj = as(s);

    // print("\n");

    // List str = [];

    // as();
    // Future str = getEmailComp();
    // print(str);

    //print(str);
    // print("Length: $emailcomp");
    // var subject = emailcomp[0];
    // var emailaddress = emailcomp[1];
    // int i = 0;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: ListView(
//         children: [
//           Column(
//             children: [
//               Stack(
//                 children: const [
//                   //Header(),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//               SizedBox(
//                 height: 30,
//                 child: Stack(
//                   children: [
//                     Row(
//                       //mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         Padding(
//                           padding: EdgeInsets.only(left: 60),
//                           child: Text(
//                             "Inbox",
//                             style: TextStyle(
//                                 //backgroundColor: Colors.tealAccent,
//                                 color: Color(0xFFE91E63),
//                                 // decoration: TextDecoration.underline,
//                                 // decorationThickness: 1,
//                                 // decorationColor:
//                                 //     Color.fromARGB(255, 46, 63, 63),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0),
//               // Container(
//               //   height: 2,
//               //   child: Container(
//               //     color: Color.fromARGB(147, 100, 1, 50),
//               //   ),
//               // ),

//               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//               for (var header = 0; header < 10; header++)
//                 MessageGesture(
//                   emailaddress: "sender[header]",
//                   subject: "subject[header]",
//                   // body: bod[i++],
//                   // time: '23:15',
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




  // Map subemail = {};
  // List subject = [];
  // List sender = [];

  // void initState() {
  //   super.initState();
  //   getheader();
  // }

  //List bod = [];

  // late String s = '';

  //previous version
  //s

  // List subject(String response) {
  //   // Future<List> a = getEmailComp();
  //   // str = await a;
  //   // print(str);
  //   final decoded = json.decode(response);
  //   // setState(() {
  //   //   sub = decoded['Subject'];
  //   // });
  //   sub = decoded['Subject'];
  //   // print(Sub);
  //   return decoded['Subject'];
  // }

  // List emailaddress(String response) {
  //   // Future<List> a = getEmailComp();
  //   // str = await a;
  //   // print(str);
  //   final decoded = json.decode(response);
  //   // setState(() {
  //   //   sen = decoded['Sender'];
  //   // });
  //   sen = decoded['Sender'];
  //   // print(Sub);
  //   return decoded['Sender'];
  // }

  // // List body(String response) {
  // //   // Future<List> a = getEmailComp();
  // //   // str = await a;
  // //   // print(str);
  // //   final decoded = json.decode(response);
  // //   // setState(() {
  // //   //   sen = decoded['Sender'];
  // //   // });
  // //   bod = decoded['Body'];
  // //   // print(Sub);
  // //   return decoded['Body'];
  // // }

  // Future getSubject() async {
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return subject(response.body);
  // }

  // Future getEmail() async {
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return emailaddress(response.body);
  // }

  // Future getBody() async {
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return body(response.body);
  // }

  //previous version
  //e
