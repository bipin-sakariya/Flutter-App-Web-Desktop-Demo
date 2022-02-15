import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_macos_demo/main.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Account"),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
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
                  // keyboardType: TextInputType.visiblePassword,
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
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
                      // developer.log(newUser.toString(), name: "CREATED USER");

                      if (newUser.user?.email == email.text) {
                        setState(() {
                          email.clear();
                          password.clear();
                        });
                      }
                      // Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
                    }
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
    );
  }
}
