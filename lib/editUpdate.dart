import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:http/http.dart' as http;
import 'package:the_address_pms/Model/signUpmodel.dart';
import 'package:the_address_pms/list.dart';

class EditPage extends StatefulWidget {
  // const editPage({super.key});
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
  // const SignUpForm({super.key});

  final Post? postModel2;
  SignUpForm({this.postModel2});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _passKey = GlobalKey<FormFieldState>();

  String _name = '';
  String _email = '';
  // int _age = -1;
  // String _maritalStatus = 'single';
  int _selectGender = 1;
  String _password = '';
  int _contactNo = 0;
  // bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));

    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));

    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  int _id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.postModel2 != null) {
      _name = widget.postModel2!.name.toString();
      _email = widget.postModel2!.email.toString();
      _selectGender = int.parse(widget.postModel2!.gender.toString());
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

      //   onSaved: (value) {
      //   setState(() {
      //     _name = value.toString();
      //   });
      // },
    ));
    formWidget.add(TextFormField(
      initialValue: _email,
      decoration:
          const InputDecoration(labelText: 'Enter email', hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      // onSaved: (value) {
      //   setState(() {
      //     _email = value.toString();
      //   });
      // },

      onChanged: (value) {
        _email = value.toString();
      },
    ));

    // formWidget.add(TextFormField(
    //   decoration:
    //       const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
    //   keyboardType: TextInputType.number,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return 'Enter age';
    //     } else {
    //       return null;
    //     }
    //   },
    //   onChanged: (value) {
    //     _age = int.parse(value.toString());
    //   },
    //   //  onSaved: (value) {
    //   //   setState(() {
    //   //     _age = int.parse(value.toString());
    //   //   });
    //   // }
    // ));
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

    // formWidget.add(Column(
    //   children: <Widget>[
    //     RadioListTile<String>(
    //       title: const Text('Single'),
    //       value: 'single',
    //       groupValue: _maritalStatus,
    //       onChanged: (value) {
    //         setState(() {
    //           _maritalStatus = value.toString();
    //         });
    //       },
    //     ),
    //     RadioListTile<String>(
    //       title: const Text('Married'),
    //       value: 'married',
    //       groupValue: _maritalStatus,
    //       onChanged: (value) {
    //         setState(() {
    //           _maritalStatus = value.toString();
    //         });
    //       },
    //     ),
    //   ],
    // ));

    formWidget.add(
      TextFormField(
          key: _passKey,
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

    // formWidget.add(CheckboxListTile(
    //   value: _termsChecked,
    //   onChanged: (value) {
    //     setState(() {
    //       _termsChecked = value.toString().toLowerCase() == 'true';
    //     });
    //   },
    //   subtitle: !_termsChecked
    //       ? const Text(
    //           'Required',
    //           style: TextStyle(color: Colors.red, fontSize: 12.0),
    //         )
    //       : null,
    //   title: const Text(
    //     'I agree to the terms and condition',
    //   ),
    //   controlAffinity: ListTileControlAffinity.leading,
    // ));

    Future<void> onPressedSubmit() async {
      // if (_formKey.currentState!.validate() && _termsChecked) {
      //   _formKey.currentState?.save();

      // Product product = new Product();

      // product.name = _name;
      // product.email = _email;
      // product.price = _age.toString();
      // product.quantity = _password;

      // (await ProductApiService().createProduct(product));
      // // print("Delete Call!");
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => ViewList(),
        ),
        (route) => false,
      );

      print("Name " + _name);
      print("Email " + _email);
      // print("Age " + _age.toString());
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
      // print("Marital Status " + _maritalStatus);
      print("Password " + _password);
      // print("Termschecked " + _termsChecked.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Form Submitted')));

      // Navigator.pushAndRemoveUntil<dynamic>(context,
      //   MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) =>Home(),
      //   ),
      //       (route) =>false,
      // );
      // }

      final String url =
          'https://theaddresspmsrestapispring-production.up.railway.app/api/signUps';
      var reqBody = {
        "name": _name,
        "email": _email,
      };
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonResponse = jsonDecode(response.body);
      // if (jsonResponse['status']) {
      //   print('Data Submitted');
      // } else {
      //   print('something went wrong');
      // }
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
          // Navigator.pushAndRemoveUntil<dynamic>(context,
          //   MaterialPageRoute<dynamic>(
          //     builder: (BuildContext context) =>Home(),
          //   ),
          //       (route) =>false,
          // );
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
