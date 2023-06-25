import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_address_pms/log.dart';
import 'package:the_address_pms/signUp.dart';

import 'list.dart';

void main() {
  runApp(LogInForm());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewList(),
    );
  }
}

displayToastMassage(String massage, BuildContext) {
  Fluttertoast.showToast(msg: massage);
}

class Massage extends StatelessWidget {
  const Massage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: ElevatedButton(
        onPressed: () {
          displayToastMassage("HIIIIIII", context);
        },
        child: Text("click here"),
      ))),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignUp());
  }
}
