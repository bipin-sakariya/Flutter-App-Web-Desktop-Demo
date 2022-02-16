import 'package:firebase_macos_demo/responsive.dart';
import 'package:firebase_macos_demo/signup.dart';
import 'package:flutter/material.dart';

import 'image_page.dart';

class SignUpMainScreen extends StatelessWidget {
  const SignUpMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Expanded(
          child: SignUpPage(),
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: SignUpPage(),
            ),
            Expanded(flex: 6, child: ImagePage())
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              child: SignUpPage(),
            ),
            Expanded(flex: 1, child: ImagePage())
          ],
        ),
      ),
    );
  }
}
