import 'package:firebase_macos_demo/responsive.dart';
import 'package:flutter/material.dart';

import 'image_page.dart';
import 'login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: Expanded(
          child: LoginUserPage(),
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: LoginUserPage(),
            ),
            Expanded(flex: 6, child: ImagePage())
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              child: LoginUserPage(),
            ),
            Expanded(flex: 1, child: ImagePage())
          ],
        ),
      ),
    );
  }
}
