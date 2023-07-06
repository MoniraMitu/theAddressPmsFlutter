import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:http/http.dart' as http;
import 'package:the_address_pms/Model/signUpmodel.dart';
import 'package:the_address_pms/list.dart';
import 'package:the_address_pms/service/service.dart';

class EditPage extends StatefulWidget {
  final Post? postModel;
  EditPage({this.postModel});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Form"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SignUpForm(postModel2: widget.postModel),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final Post? postModel2;
  SignUpForm({this.postModel2});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _passKey = GlobalKey<FormFieldState>();

  String _name = '';
  String _email = '';

  int _selectGender = 1;
  String _password = '';
  int _contactNo = 0;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 0,
    ));

    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 1,
    ));

    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  int _id = 0;

  @override
  void initState() {
    super.initState();

    if (widget.postModel2 != null) {
      _name = widget.postModel2!.name.toString();
      _email = widget.postModel2!.email.toString();

      if (widget.postModel2!.gender.toString() == "Female") {
        _selectGender = 0;
      } else if (widget.postModel2!.gender.toString() == "Others") {
        _selectGender = 2;
      } else {
        _selectGender = 1;
      }

      _password = widget.postModel2!.password.toString();
      _contactNo = widget.postModel2!.contactNo!;
      _id = widget.postModel2!.id!;
    }
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    return Form(
      child: ListView(
        children: getFormWidget(),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      initialValue: _name,
      decoration:
          const InputDecoration(labelText: 'Enter name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter a name';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        _name = value.toString();
      },
    ));
    formWidget.add(TextFormField(
      initialValue: _email,
      decoration:
          const InputDecoration(labelText: 'Enter email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        _email = value.toString();
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('select gender'),
      items: genderList,
      value: _selectGender,
      onChanged: (value) {
        setState(() {
          _selectGender = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(
      TextFormField(
          key: _passKey,
          initialValue: _password,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: 'Password', labelText: 'Enter Password'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter password';
            } else if (value.length < 8) {
              return 'Password should be more than 8 characters';
            } else {
              return null;
            }
          }),
    );

    formWidget.add(
      TextFormField(
          obscureText: true,
          initialValue: _password,
          decoration: const InputDecoration(
              hintText: 'Confirm Password',
              labelText: 'Enter Confirm Password'),
          validator: (confirmPassword) {
            if (confirmPassword != null && confirmPassword.isEmpty) {
              return 'Enter confirm password';
            }
            var password = _passKey.currentState?.value;
            if (confirmPassword != null &&
                confirmPassword.compareTo(password) != 0) {
              return 'Password mismatch';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            _password = value.toString();
          }),
    );

    Future<void> onPressedSubmit() async {
      print("Name " + _name);
      print("Email " + _email);

      switch (_selectGender) {
        case 0:
          print("Gender Male");
          break;
        case 1:
          print("Gender Female");
          break;
        case 3:
          print("Gender Others");
          break;
      }

      print("Password " + _password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Form Submitted')));

      Post ps = new Post();

      ps.name = _name;
      ps.email = _email;
      ps.contactNo = _contactNo;

      print("-----------------------------------------");
      print(_selectGender);
      switch (_selectGender) {
        case 0:
          ps.gender = " Male";
          break;
        case 1:
          ps.gender = "Female";
          break;
        case 3:
          ps.gender = "Other";
          break;
      }
      ps.password = _password;

      if (widget.postModel2 != null) {
        ps.id = _id;
      }

      (await Service2().createPost(ps));

      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ViewList(),
        ),
        (route) => false,
      );
    }

    formWidget.add(ElevatedButton(
        child: const Text('Update'), onPressed: onPressedSubmit));

    formWidget.add(ElevatedButton(
        child: const Text('Home'),
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ViewList(),
            ),
            (route) => false,
          );
        }));

    return formWidget;
  }
}

validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'please enter email';
  }
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value.toString())) {
    return 'enter valid email';
  } else {
    return null;
  }
}
