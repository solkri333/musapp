// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'messages.dart';

class MessageGesture extends StatelessWidget {
  const MessageGesture({
    super.key,
    required this.emailaddress,
    required this.subject,
    required this.msg,
    // required this.time,
    // required this.body,
    this.shadowcolor = 0xFFE91E63,
  });
  final String emailaddress;
  final String subject;
  final msg;
  // final String time;
  // final String body;
  final shadowcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 10),
      child: Column(
        // padding: const EdgeInsets.only(left: 6.0, right: 4.0),
        children: [
          GestureDetector(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  // color: Colors.grey[350],
                  // color: Color.fromARGB(255, 249, 248, 248),
                  color: const Color.fromARGB(255, 247, 247, 247),
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(4, 2),
                        color: Color(shadowcolor),
                        blurRadius: 2)
                  ]),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Icon(Icons.circle,
                        color: Color.fromARGB(255, 77, 60, 106), size: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        child: RichText(
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: emailaddress,
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      subject,
                      style: const TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.star_border,
                        color: Color.fromARGB(255, 144, 35, 71)),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MessagePage(
                            subject: subject,
                            emailaddress: emailaddress,
                            msgId: msg,
                            // body: body
                          )));
            },
          ),
        ],
      ),
    );
  }
}
