import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_address_pms/list.dart';
import 'package:the_address_pms/main.dart';
import 'package:the_address_pms/signUp.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage("img/img1.jpeg"),
            height: 250,
            width: 390,
            alignment: Alignment.center,
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            "Login as User",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              const SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(fontSize: 30, color: Colors.amber),
                ),
                style: TextStyle(fontSize: 10.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 14.0),
                  hintStyle: TextStyle(fontSize: 30, color: Colors.amber),
                ),
                style: TextStyle(fontSize: 10.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)))),
                  child: Container(
                    height: 50.0,
                    child: Text(
                      "Log IN",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  onPressed: () {
                   
                    if (!email.text.contains("@")) {
                      displayToastMassage("Invalid email", BuildContext);
                    } 
                    if (password.text.length < 3) {
                      displayToastMassage("Invalid password", BuildContext);
                    }
                    // {
                    //   displayToastMassage(
                    //       "Hello !! ${email.text} !! ${password.text}",
                    //       BuildContext);
                    // }

                     Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => ViewList(),
                      ),
                      (route) => false,
                    );
                  }),
              TextButton(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.blue),
                  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //         RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(24.0)))),
                  child: Container(
                    height: 50.0,
                    child: Text(
                      "Don't have an Account ? Sign Up Now..!!!",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => SignUp(),
                      ),
                      (route) => false,
                    );
                  })
            ]),
          )
        ]),
      )),
    );
  }
}
