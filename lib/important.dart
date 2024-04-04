import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'header.dart';
import 'MessageGesture.dart';
import 'messageFetcher.dart';

class ImportantPage extends StatefulWidget {
  const ImportantPage({super.key});

  @override
  State<ImportantPage> createState() => _ImportantPage();
}

class _ImportantPage extends State<ImportantPage> {
  late Future<Map<String, List>> _future;
  Map<String, List> subemails = {};
  MessageDisplay messageDisplay = const MessageDisplay();
  @override
  void initState() {
    super.initState();
    _future = messageDisplay.getImportant();
  }
  // Map subemail = {};
  // List sub = [];
  // List sen = [];
  // late String s = '';
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

  // Future getSubject() async {
  //   final response =
  //       await http.get(Uri.parse('http://127.0.0.1:5000/important'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return subject(response.body);
  // }

  // Future getEmail() async {
  //   final response =
  //       await http.get(Uri.parse('http://127.0.0.1:5000/important'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return emailaddress(response.body);
  // }

  //Future
  // Future<Map<String, List>> getImportant(
  //     {String url = 'http://127.0.0.1:5000/important'}) async {
  //   final response = await http.get(Uri.parse(url));
  //   final decoded = json.decode(response.body);
  //   //Map<String, List> subemails = {};
  //   subemails['Subject'] = decoded['Subject'];
  //   subemails['Sender'] = decoded['Sender'];
  //   return subemails;
  // }

  // void getheader() {
  //   setState(() async {
  //     subemail = await getPrimary();
  //   });
  // }

  // int once = 1;
  // @override
  // Widget build(BuildContext context) {
  //   getheader();

  // getSubject();
  // getEmail();
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
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Stack(
  //             children: const [
  //               Header(),
  //             ],
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.height * 0.04),
  //           SizedBox(
  //             height: 30,
  //             child: Stack(
  //               children: [
  //                 Row(
  //                   //mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 60),
  //                       child: Text(
  //                         "Important",
  //                         style: TextStyle(
  //                             //backgroundColor: Colors.tealAccent,
  //                             color: Colors.blueAccent.shade700,
  //                             //decoration: TextDecoration.underline,
  //                             // decorationThickness: 1.5,
  //                             // decorationColor: Colors.orangeAccent,
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 20),
  //                       ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: MediaQuery.of(context).size.height * 0),
  //           // Container(
  //           //   height: 2,
  //           //   child: Container(
  //           //     color: Color.fromARGB(147, 100, 1, 50),
  //           //   ),
  //           // ),

  //           SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //           for (var header in subemail['Sender'].zip(subemail['Subject']))
  //             MessageGesture(
  //               emailaddress: header.first,
  //               subject: header.second,
  //               // time: '23:15',
  //               shadowcolor: 0xFF157F1F,
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //new
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.grey,
          // backgroundColor: Colors.white70,
          backgroundColor: const Color.fromARGB(255, 72, 135, 29),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20.0),
              child: Row(
                //padding: EdgeInsets.only(left: 50),
                children: [
                  Text(
                    "Important",
                    style: TextStyle(
                        //backgroundColor: Colors.tealAccent,
                        color: Color(0xFF6AB837),
                        //decoration: TextDecoration.underline,
                        // decorationThickness: 1.5,
                        // decorationColor: Colors.orangeAccent,
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
                        child: ListView.builder(
                          itemCount: sender?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageGesture(
                              emailaddress: sender?[index],
                              subject: subject?[index],
                              msg: payload?[index],
                              shadowcolor: 0xFF6AB837,
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                          controller: ScrollController(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
