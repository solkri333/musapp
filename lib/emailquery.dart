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
              actions: [
                InkWell(
                  onTap: () {},
                  // // onHover: (isHovered) {
                  // //   setState(() {
                  // //     _isHovered = isHovered;
                  // //   });
                  // },
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 47, 94, 223)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // boxShadow: _isHovered
                      //     ? [
                      //         BoxShadow(
                      //           // color: const Color.fromARGB(200, 65, 133, 222)
                      //           //     .withOpacity(0.8),
                      //           color: const Color.fromARGB(255, 0, 0, 139)
                      //               .withOpacity(0.8),
                      //           spreadRadius: 2,
                      //           blurRadius: 2,
                      //           offset: const Offset(-4.2, 4.2),
                      //         ),
                      //       ]
                      //     : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_month, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Save to Calender',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
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
  bool optionsVisible = false;
  List<dynamic> options = ["No url found"];
  final TextEditingController textController = TextEditingController();
  late final GlobalKey<AnimatedListState> _listKey;
  List<dynamic> inputHistory = [summary];

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
  }

  void toggleOptionsVisibility() {
    setState(() {
      optionsVisible = !optionsVisible;
    });
  }

  void handleOptionSelected(String option) async {
    toggleOptionsVisibility();
    if (option == "No url found") return;
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/webpage'),
        body: json.encode({'url': option}));
    try {
      final error = json.decode(response.body)["error"];
      setState(() {
        inputHistory.insert(0, error);
        _listKey.currentState!
            .insertItem(0, duration: const Duration(milliseconds: 250));
      });
      return;
    } catch (e) {
      print(e);
    }
    setState(() {
      final img = response.bodyBytes;
      inputHistory.insert(0, img);
      _listKey.currentState!
          .insertItem(0, duration: const Duration(milliseconds: 250));
    });
    print("Option Selected");
  }

  @override
  Widget build(BuildContext context) {
    _checkUrl();
    return Stack(
      children: <Widget>[
        Column(
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
                    child: _buildItem(inputHistory[index], icon, animation,
                        index, inputHistory.length),
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
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () => toggleOptionsVisibility(),
                    backgroundColor: Colors.amberAccent,
                    child: const Icon(Icons.link),
                  ),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: optionsVisible,
          child: Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: options.map((option) {
                  const SizedBox(height: 10);
                  return ElevatedButton(
                    onPressed: () {
                      handleOptionSelected(option);
                    },
                    child: Text(option),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(dynamic element, Icon icon, Animation<double> animation,
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
          title: String == element.runtimeType
              ? Text(
                  element,
                  style: const TextStyle(color: Colors.white),
                )
              : SizedBox(
                  width: 1100,
                  height: 400,
                  child: Image(image: MemoryImage(element))),
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

  Future<dynamic> _checkUrl() async {
    // Simulating response
    final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/checkUrl'),
        body: json.encode({"summary": summary}));
    final answer = json.decode(response.body)['answer'];
    if (answer.length > 0) options = answer;
    print(options);
    return json.decode(response.body)['answer'];
  }
}
