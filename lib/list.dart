import 'package:flutter/material.dart';
import 'package:the_address_pms/Model/signUpmodel.dart';
import 'package:the_address_pms/edit.dart';

import 'package:the_address_pms/service/service.dart';

class ViewList extends StatefulWidget {
  const ViewList({super.key});

  @override
  State<ViewList> createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  late List<Post>? _postList = [];

  void _getData() async {
    _postList = (await Service2().getPost())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(
          () {},
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  Widget _getPostList(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example for Post'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/p4', (route) => false);
                // goBack(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp))
        ],
      ),
      body: _postList == null || _postList!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.builder(
                itemCount: _postList!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(_postList![index].name.toString()),
                    subtitle: Text(_postList![index].email.toString()),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                editList(edit: _postList![index]),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getPostList(context);
  }
}
