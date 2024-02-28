import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'homepage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:googleapis/identitytoolkit/v3.dart';
// import 'package:googleapis_auth/googleapis_auth.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           constraints: const BoxConstraints.expand(width: 300),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),
//               Container(child: const Text("Login")),
//               // Container(
//               //   //color: Colors.grey.shade100,
//               //   //height: 50,
//               //   //  constraints: BoxConstraints.expand(height: 100),
//               //   padding: EdgeInsets.all(15.0),
//               //   alignment: Alignment(0, 0),
//               // ),
//               const SizedBox(height: 35),
//               TextField(
//                 decoration: InputDecoration(
//                     filled: true,
//                     border: const OutlineInputBorder(),
//                     fillColor: Colors.tealAccent.shade400,
//                     //contentPadding: EdgeInsets.all(10),
//                     helperStyle: TextStyle(color: Colors.grey.shade400),
//                     helperText: "use email to sign in",
//                     labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//                     enabledBorder: const OutlineInputBorder(),
//                     alignLabelWithHint: true,
//                     labelText: "Email Address",
//                     hintText: "abcde@example.com"),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.tealAccent.shade400,
//                   border: const OutlineInputBorder(),
//                   labelText: "Password",
//                   labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//                   enabledBorder: const OutlineInputBorder(),
//                   alignLabelWithHint: true,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton.icon(
//                   style: const ButtonStyle(
//                       elevation: MaterialStatePropertyAll(5),
//                       backgroundColor:
//                           MaterialStatePropertyAll(Colors.black87)),
//                   onPressed: () {
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (context) => const MyHomePage(),
//                     //     ));
//                     GoogleSignInPage _signIn =
//                         GoogleSignInPage(context: context);
//                     _signIn._handleSignIn();
//                     print("SignIn button clicked");
//                   },
//                   icon: Icon(
//                     Icons.arrow_circle_right_outlined,
//                     color: Colors.blue.shade800,
//                   ),
//                   label: const Text(
//                     "Sign In",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// typedef SignInCallback = Future<void> Function();
// const String apiKey = 'AIzaSyAVPSN-JSbzyawmYX92zB4dVbHbzsHr8AI';

// const GOOGLE_CLIENT_ID =
//     '1060506162498-00thhu3ftccou70fibao6oj3jr1deia6.apps.googleusercontent.com';
// const REDIRECT_URI = 'https://musapp-6667.firebaseapp.com/__/auth/handler';

// class GoogleSignInPage extends StatelessWidget {
//   final BuildContext context;
//   SignInCallback signInWithArgs(BuildContext context, ProviderArgs args) =>
//       () async {
//         print("This was called");
//         final result = await DesktopWebviewAuth.signIn(args);
//         notify(context, result?.toString());
//       };

//   void notify(BuildContext context, String? result) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Result: $result'),
//       ),
//     );
//   }
//   // final GoogleSignIn _googleSignIn = GoogleSignIn(
//   //   // Specify the desired scopes
//   //   scopes: [
//   //     'email',
//   //     'https://www.googleapis.com/auth/gmail.readonly',
//   //     // Add more scopes as needed
//   //   ],
//   // );

//   GoogleSignInPage({super.key, required this.context});

//   // BuildContext? get context => null;

//   Future<void> _handleSignIn() async {
//     var googleSignInAccount = null;
//     try {
//       // Sign in with Google
//       // GoogleSignInArgs(
//       //   clientId: GOOGLE_CLIENT_ID,
//       //   redirectUri: REDIRECT_URI,
//       //   scope: 'https://www.googleapis.com/auth/plus.me '
//       //       'https://www.googleapis.com/auth/userinfo.email',
//       // );
//       // googleSignInAccount = GoogleSignInArgs(
//       //     clientId: GOOGLE_CLIENT_ID,
//       //     redirectUri: REDIRECT_URI,
//       //     scope: 'https://www.googleapis.com/auth/gmail.readonly');
//       googleSignInAccount = signInWithArgs(
//           context,
//           GoogleSignInArgs(
//               clientId: GOOGLE_CLIENT_ID,
//               redirectUri: REDIRECT_URI,
//               scope: 'https://www.googleapis.com/auth/gmail.readonly'));
//       print("Here");
//       if (googleSignInAccount != null) {
//         // User signed in successfully
//         final userId = googleSignInAccount;
//         print(userId);
//         // Send user ID to the backend

//         // Navigator.push(
//         //     context!,
//         //     MaterialPageRoute(
//         //       builder: (context) => const MyHomePage(),
//         //     ));

//         // await sendUserIdToBackend(userId);
//         // Navigate to the next screen or perform further actions
//         // Example:
//         // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
//       } else {
//         // User cancelled the sign-in process
//         // Handle accordingly
//       }
//     } catch (error) {
//       // Handle sign-in errors
//       print('Error signing in with Google: $error');
//     }
//   }

//   // Future<void> sendUserIdToBackend(String userId) async {
//   //   // Send user ID to your backend
//   //   // Example: Send a POST request with user ID to your backend API
//   //   String apiUrl = 'http://127.0.0.1:5000/receive_user_id';
//   //   Map<String, String> headers = {'Content-Type': 'application/json'};
//   //   Map<String, String> body = {'userId': userId};

//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: headers,
//   //       body: jsonEncode(body),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       // User ID sent successfully
//   //       print('User ID sent to backend successfully');
//   //     } else {
//   //       // Failed to send user ID
//   //       print('Failed to send user ID to backend');
//   //     }
//   //   } catch (error) {
//   //     // Handle errors
//   //     print('Error sending user ID to backend: $error');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

//new

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:desktop_webview_auth/desktop_webview_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(width: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text("Login"),
              const SizedBox(height: 35),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(),
                  fillColor: Colors.tealAccent.shade400,
                  helperStyle: TextStyle(color: Colors.grey.shade400),
                  helperText: "use email to sign in",
                  labelStyle: TextStyle(fontWeight: FontWeight.w600),
                  enabledBorder: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  labelText: "Email Address",
                  hintText: "abcde@example.com",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.tealAccent.shade400,
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  backgroundColor: MaterialStateProperty.all(Colors.black87),
                ),
                onPressed: () async {
                  if (await signIn())
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ));
                  else
                    print("An error occured");
                },
                icon: Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.blue.shade800,
                ),
                label: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> signIn() async {
  // Send user ID to your backend
  // Example: Send a POST request with user ID to your backend API
  String apiUrl = 'http://127.0.0.1:5000/signIn';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
    );
    final decoded = json.decode(response.body);
    if (decoded['statusCode'] == 200) {
      // User ID sent successfully
      print(decoded['result']);
      return true;
    } else {
      // Failed to send user ID
      print(decoded.error);
    }
  } catch (error) {
    // Handle errors
    print('Error signing in: $error');
  }
  return false;
}
