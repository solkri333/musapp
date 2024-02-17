import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({
    Key? key,
    required this.subject,
    required this.emailaddress,
    required this.msgId,
  }) : super(key: key);

  final String subject;
  final String emailaddress;
  final String msgId;

  Future _messages() async {
    final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/messages'),
        body: json.encode({"msgId": msgId}));
    final response1 =
        await http.get(Uri.parse('http://127.0.0.1:5000/messages'));
    final decoded = json.decode(response1.body);
    return decoded["body"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _messages(),
      builder: (context, snapshot) {
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

        final messageData = snapshot.data!;
        final message = utf8.decode(base64Decode(messageData));
        final isHtml = message.contains(RegExp(r'<[^>]*>'));
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
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Tooltip(
                      message: 'Change Label',
                      waitDuration: const Duration(milliseconds: 250),
                      showDuration: const Duration(milliseconds: 100),
                      child: IconButton(
                        color: Colors.amber[300],
                        onPressed: () {},
                        icon: const Icon(Icons.label),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Tooltip(
                      message: 'Spam',
                      waitDuration: const Duration(milliseconds: 250),
                      showDuration: const Duration(milliseconds: 100),
                      child: IconButton(
                        color: Colors.red[400],
                        onPressed: () {},
                        icon: const Icon(Icons.report_gmailerrorred),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Tooltip(
                      message: 'Delete',
                      waitDuration: const Duration(milliseconds: 250),
                      showDuration: const Duration(milliseconds: 100),
                      child: IconButton(
                        color: Colors.grey[800],
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline_outlined),
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
                      subject,
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
                        emailaddress,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Html(
                      // message,
                      data: message,
                      style: {
                        // Define the style properties for the HTML content
                        'body': Style(
                          fontSize: const FontSize(24.0),
                          margin: const EdgeInsets.only(left: 20, right: 80.0),
                          fontWeight: FontWeight.w400,
                        ),
                        // Add more style definitions if needed
                      },
                    )
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
