import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  ImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd7daff),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Image.asset("login.png"),
              )),
        ));
  }
}
