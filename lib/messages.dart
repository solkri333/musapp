import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'emailquery.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
    required this.subject,
    required this.emailaddress,
    required this.msgId,
  }) : super(key: key);

  final String subject;
  final String emailaddress;
  final String msgId;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future _messages() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/messages'),
        body: json.encode({"msgId": widget.msgId}));
    // final response1 =
    //     await http.get(Uri.parse('http://127.0.0.1:5000/messages'));
    final decoded = json.decode(response.body);
    return decoded["body"];
  }

  bool _isHovered = false;
  int first = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _messages(),
      builder: (context, snapshot) {
        if (first++ == 0) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Error fetching message')),
            );
          } else if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: Text('No message found')),
            );
          }
        }

        final messageData = snapshot.data!;
        final message = utf8.decode(base64Decode(messageData));
        // final isHtml = message.contains(RegExp(r'<[^>]*>'));
        // final parts = messageData['payload']['parts'];

        // var decodedHtml = '';
        // var plainText = '';

        // if (parts != null && parts.isNotEmpty) {
        //   final htmlPart = parts.firstWhere(
        //     (part) => part['mimeType'] == 'text/html',
        //     orElse: () => null,
        //   );

        //   if (htmlPart != null) {
        //     final bodyData = htmlPart['body']['data'];
        //     decodedHtml = utf8.decode(base64.decode(bodyData));
        //   }

        //   final plainTextPart = parts.firstWhere(
        //     (part) => part['mimeType'] == 'text/plain',
        //     orElse: () => null,
        //   );

        //   if (plainTextPart != null) {
        //     final bodyData = plainTextPart['body']['data'];
        //     plainText = utf8.decode(base64.decode(bodyData));
        //   }
        // }

        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.blue[600],
            toolbarHeight: 60,
            elevation: 0,
            backgroundColor: Colors.white38,
            actions: [
              Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 5.0),
                  //   child: Tooltip(
                  //     message: 'Change Label',
                  //     waitDuration: const Duration(milliseconds: 250),
                  //     showDuration: const Duration(milliseconds: 100),
                  //     child: IconButton(
                  //       color: Colors.amber[300],
                  //       onPressed: () {},
                  //       icon: const Icon(Icons.label),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 5.0),
                  // child: Tooltip(
                  //     message: 'Summarize',
                  //     waitDuration: const Duration(milliseconds: 250),
                  //     showDuration: const Duration(milliseconds: 100),
                  //     child:
                  // IconButton(
                  //   color: Colors.red[400],
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.report_gmailerrorred),
                  // ),
                  // ElevatedButton.icon(
                  //     style: ButtonStyle(
                  //         shape: MaterialStatePropertyAll(
                  //             RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(10))),
                  //         overlayColor:
                  //             MaterialStateProperty.resolveWith<Color?>(
                  //           (Set<MaterialState> states) {
                  //             if (states.contains(MaterialState.hovered)) {
                  //               return const Color.fromARGB(255, 6, 99, 146);
                  //             } else
                  //               // ignore: curly_braces_in_flow_control_structures
                  //               return null;
                  //           },
                  //         ),
                  //         backgroundColor:
                  //             MaterialStatePropertyAll(Colors.purple.shade800),
                  //         visualDensity: VisualDensity.comfortable,
                  //         elevation: const MaterialStatePropertyAll(4),
                  //         shadowColor:
                  //             const MaterialStatePropertyAll(Colors.black)),
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.summarize,
                  //       color: Colors.white54,
                  //     ),
                  //     label: const Text(
                  //       "Summarize",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontStyle: FontStyle.italic,
                  //           color: Colors.white),
                  //     )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Summarizer(body: message),
                          ));
                    },
                    onHover: (isHovered) {
                      setState(() {
                        _isHovered = isHovered;
                      });
                    },
                    // child: AnimatedContainer(
                    //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    //   decoration: BoxDecoration(
                    //     color:
                    //         _isHovered ? Colors.white.withOpacity(0.0) : Colors.transparent,
                    //     border: Border.all(
                    //         color: Colors.transparent,
                    //         style: BorderStyle.solid,
                    //         strokeAlign: 0,
                    //         width: 1),
                    //     boxShadow: _isHovered
                    //         ? [
                    //             BoxShadow(
                    //               color: Color.fromARGB(200, 65, 133, 222).withOpacity(0.5),
                    //               spreadRadius: 20,
                    //               blurRadius: 50,
                    //               // blurRadius: 10,
                    //             )
                    //           ]
                    //         : [BoxShadow(color: Colors.white)],
                    //   ),
                    // duration: const Duration(milliseconds: 250),
                    child: AnimatedContainer(
                      // clipBehavior: Clip.antiAlias,
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        border: _isHovered
                            ? Border.all(color: Colors.blueAccent.shade700)
                            : Border.all(
                                color: const Color.fromARGB(255, 47, 94, 223)),
                        color: _isHovered
                            // ? Colors.blueAccent.shade700
                            ? const Color.fromARGB(255, 65, 105, 225)
                            : Colors.white,
                        borderRadius:
                            BorderRadius.circular(_isHovered ? 15 : 15),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  // color: const Color.fromARGB(200, 65, 133, 222)
                                  //     .withOpacity(0.8),
                                  color: const Color.fromARGB(255, 0, 0, 139)
                                      .withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(-4.2, 4.2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.summarize,
                            color: _isHovered
                                ? Colors.greenAccent.shade400
                                : Colors.blueAccent.shade400,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Summarize',
                            style: TextStyle(
                              color:
                                  _isHovered ? Colors.white : Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: _isHovered
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                    child: Tooltip(
                      message: 'Favourites',
                      waitDuration: const Duration(milliseconds: 250),
                      showDuration: const Duration(milliseconds: 100),
                      child: IconButton(
                        color: Colors.pink[800],
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Tooltip(
                      message: 'More options',
                      waitDuration: const Duration(milliseconds: 250),
                      showDuration: const Duration(milliseconds: 100),
                      child: IconButton(
                        color: Colors.black,
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_sharp),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          backgroundColor: Colors.grey[100],
          body: Padding(
            padding: const EdgeInsets.only(left: 100, top: 50),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        widget.emailaddress,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        message,
                        overflow: TextOverflow.clip,
                      ),
                    )
                    // Html(
                    //   // message,
                    //   data: message,
                    //   style: {
                    //     // Define the style properties for the HTML content
                    //     'body': Style(
                    //       fontSize: const FontSize(24.0),
                    //       margin: const EdgeInsets.only(left: 20, right: 80.0),
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //     // Add more style definitions if needed
                    //   },
                    // )
                    // if (decodedHtml.isNotEmpty)
                    //   Html(
                    //     data: decodedHtml,
                    //     style: {'body': Style(fontSize: const FontSize(20))},
                    //   ),
                    // if (decodedHtml.isEmpty && plainText.isNotEmpty)
                    //   Text(
                    //     plainText,
                    //     style: const TextStyle(fontSize: 18),
                    //   ),
                    // if (decodedHtml.isEmpty && plainText.isEmpty)
                    //   Padding(
                    //     padding: const EdgeInsets.all(20.0),
                    //     child: Text(
                    //       'No content to display.',
                    //       style: const TextStyle(fontSize: 18),
                    //     ),
                    //   ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
