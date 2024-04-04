import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'messageGesture.dart';
import 'messageFetcher.dart';

class SpamPage extends StatefulWidget {
  const SpamPage({super.key});

  @override
  State<SpamPage> createState() => _SpamPage();
}

class _SpamPage extends State<SpamPage> {
  late Future<Map<String, List>> _future;
  MessageDisplay messageDisplay = const MessageDisplay();
  @override
  void initState() {
    super.initState();
    _future = messageDisplay.getSpam();
  }
  // Map subemail = {};
  // List subject = [];
  // List sender = [];
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
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000/spam'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return subject(response.body);
  // }

  // Future getEmail() async {
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000/spam'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return emailaddress(response.body);
  // }

  // Future<Map<String, List>> getSpam(
  //     {String url = 'http://127.0.0.1:5000/spam'}) async {
  //   final response = await http.get(Uri.parse(url));
  //   final decoded = json.decode(response.body);
  //   Map<String, List> subemails = {};
  //   subemails['Subject'] = decoded['Subject'];
  //   subemails['Sender'] = decoded['Sender'];
  //   return subemails;
  // }

  // void getheader() async {
  //   var sub = await getPrimary();
  //   setState(() {
  //     subemail = sub;
  //   });
  // }
  // Widget build(BuildContext context) {
  //   getheader();
  //   subject = subemail['Subject'];
  //   sender = subemail['Sender'];
  //   // getSubject();
  //   // getEmail();
  //   // List subj = [];
  //   // subj = as(s);

  //   // print("\n");

  //   // List str = [];

  //   // as();
  //   // Future str = getEmailComp();
  //   // print(str);

  //   //print(str);
  //   // print("Length: $emailcomp");
  //   // var subject = emailcomp[0];
  //   // var emailaddress = emailcomp[1];
  //   int i = 0;
  //   return Scaffold(
  //     body: ListView(
  //       children: [
  //         Column(
  //           children: [
  //             Stack(
  //               children: const [
  //                 Header(),
  //               ],
  //             ),
  //             SizedBox(height: MediaQuery.of(context).size.height * 0.04),
  //             SizedBox(
  //               height: 30,
  //               child: Stack(
  //                 children: [
  //                   Row(
  //                     //mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 60),
  //                         child: Text(
  //                           "Spam",
  //                           style: TextStyle(
  //                               //backgroundColor: Colors.tealAccent,
  //                               color: Colors.red.shade700,
  //                               // decoration: TextDecoration.underline,
  //                               // decorationThickness: 1.5,
  //                               // decorationColor: Colors.brown.shade600,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 20),
  //                         ),
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: MediaQuery.of(context).size.height * 0),
  //             // Container(
  //             //   height: 2,
  //             //   child: Container(
  //             //     color: Color.fromARGB(147, 100, 1, 50),
  //             //   ),
  //             // ),

  //             SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //             for (var header = 0; header < subject.length; header++)
  //               MessageGesture(
  //                 emailaddress: sender[header],
  //                 subject: subject[header],
  //                 //time: '23:15',
  //                 shadowcolor: 0xFF47313C,
  //               ),
  //           ],
  //         ),
  //       ],
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
          backgroundColor: Color.fromARGB(255, 171, 16, 16),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20.0),
              child: Row(
                //padding: EdgeInsets.only(left: 50),
                children: [
                  Text(
                    "Spam",
                    style: TextStyle(
                        //backgroundColor: Colors.tealAccent,
                        color: Colors.red.shade700,
                        // decoration: TextDecoration.underline,
                        // decorationThickness: 1.5,
                        // decorationColor: Colors.brown.shade600,
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
