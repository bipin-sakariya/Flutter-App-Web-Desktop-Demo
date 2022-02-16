import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_macos_demo/sign_up_main_screen.dart';
import 'package:firebase_macos_demo/signup.dart';
import 'package:firebase_macos_demo/userdata.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginUserPage extends StatefulWidget {
  LoginUserPage({Key? key}) : super(key: key);

  @override
  _LoginUserPageState createState() => _LoginUserPageState();
}

class _LoginUserPageState extends State<LoginUserPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/star.png",
                ),
                const SizedBox(height: 30),
                const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(height: 10),
                const Text(
                  "See your growth and get consulting support!",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "Email*",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: 'mail@website.com',
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    // do something
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Password*",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: 'Min. 8 character',
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
                  onChanged: (value) {
                    // do something
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final User user = (await _auth.signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      ))
                          .user!;
                      print(user.email);
                      if (user.email != null) {
                        setState(() {
                          email.clear();
                          password.clear();
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserListData()));
                      }
                      print(user.displayName);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(18),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    width: double.infinity,
                  ),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Not registered yet?  ',
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(color: Colors.blue, fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpMainScreen()));
                          }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    /*return Scaffold(
      appBar: AppBar(
        title: const Text("Login "),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          borderOnForeground: true,
          color: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "Enter Email"),
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: const InputDecoration(hintText: "Enter Password"),
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final User user = (await _auth.signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      ))
                          .user!;
                      print(user.email);
                      if (user.email != null) {
                        setState(() {
                          email.clear();
                          password.clear();
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserListData()));
                      }
                      print(user.displayName);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}
