import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:the_address_pms/Model/signUpmodel.dart';

import 'package:the_address_pms/editUpdate.dart';
import 'package:the_address_pms/list.dart';
import 'package:the_address_pms/service/service.dart';

class editList extends StatelessWidget {
  final Post? edit;
  const editList({super.key, this.edit});

  Widget getPost(context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 1.0),
            Text(
              "Id : " + edit!.id.toString(),
              style: TextStyle(fontSize: 30, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.0), // give it width

            Text(
              edit!.email.toString(),
              style: TextStyle(fontSize: 30, fontFamily: "bolt-semibold"),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.0), // give it width

            Container(
              child: Center(
                child: Row(children: [
                  TextButton(
                      onPressed: () async {
                        (await Service2().deletePosts(edit!.id));
                        print("Delete Call!");

                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => ViewList(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Icon(Icons.delete)),
                  TextButton(
                      onPressed: () {
                        EditPage();

                        print("Update Call!");

                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                EditPage(postModel: edit),
                          ),
                          (route) => false,
                        );
                      },
                      child: Icon(Icons.update)),
                ]),
              ),
            ),
          ],
          // Text(_postsModel![index].body.toString()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // (userModel != null) ? userModel!.name : posts!.title.toString(),
          // product!.name.toString(),
          edit!.name.toString(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, "/home", (route) => false);

                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => ViewList(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(Icons.list_alt))
        ],
      ),
      body: getPost(context),
    );
  }
}
