import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int first = 0;
String summary = "";

class Summarizer extends StatelessWidget {
  const Summarizer({super.key, required this.body});
  final String body;

  Future<String> _summary(String body) async {
    final response = await http.post(Uri.parse("http://127.0.0.1:5000/summary"),
        body: json.encode({"body": body}));
    return json.decode(response.body)["summary"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _summary(body),
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
        summary = snapshot.data!;
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.blue[600],
              toolbarHeight: 60,
              elevation: 0,
              backgroundColor: Colors.white38,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     const Padding(padding: EdgeInsets.only(left: 0)),
              //     InkWell(
              //       onTap: () {
              //         Navigator.pop(context);
              //       },
              //       child: const Icon(
              //         Icons.arrow_back,
              //         color: Color.fromARGB(255, 0, 0, 0),
              //       ),
              //     )
              //   ],
              // )
            ),
            backgroundColor: Colors.blueAccent,
            body: const Queries(),
          ),
        );
      },
    );
  }
}

class Queries extends StatefulWidget {
  const Queries({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Queries createState() => _Queries();
}

class _Queries extends State<Queries> {
  final TextEditingController textController = TextEditingController();
  late final GlobalKey<AnimatedListState> _listKey;
  List<String> inputHistory = [summary];

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: AnimatedList(
            padding: const EdgeInsets.only(left: 20, right: 20),
            key: _listKey,
            reverse: true,
            initialItemCount: inputHistory.length,
            itemBuilder: (context, index, animation) {
              var icon = (index + 1) % 2 == 0
                  ? const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 0, 162, 255),
                    )
                  : const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 240, 205, 51),
                    );
              index + 1 != inputHistory.length
                  ? const AboutDialog()
                  : icon = const Icon(Icons.circle,
                      color: Color.fromARGB(255, 63, 205, 68));
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: _buildItem(inputHistory[index], icon, animation, index,
                    inputHistory.length),
              );
            },
            physics: const BouncingScrollPhysics(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  onSubmitted: _handleSubmit,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      borderSide: BorderSide.none,
                    ),
                    hintFadeDuration: Duration(milliseconds: 250),
                    hintText: "Write your query on the mail",
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () => _handleSubmit(textController.text),
                backgroundColor: Colors.green,
                child: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String text, Icon icon, Animation<double> animation,
      int index, int length) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 18, 19, 19).withOpacity(0.2))),
        child: ListTile(
          visualDensity: VisualDensity.comfortable,
          leading: icon,
          title: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _handleSubmit(String value) async {
    if (value.isNotEmpty) {
      final question = "Q: $value";
      setState(() {
        inputHistory.insert(0, question);
        _listKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 250));
      });
      textController.clear();
      final answer = await _sendBack(value);
      setState(() {
        // inputHistory.insert(0, question);
        // _listKey.currentState!
        //     .insertItem(0, duration: const Duration(milliseconds: 250));
        inputHistory.insert(0, answer);
        _listKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 500));
      });
    }
  }

  Future<String> _sendBack(String question) async {
    // Simulating response
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/query'),
        body: json.encode({'question': question, "summary": summary}));
    return json.decode(response.body)['answer'];
  }
}
