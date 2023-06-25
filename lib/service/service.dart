import 'dart:convert';
import 'dart:developer';

import 'package:the_address_pms/Model/signUpmodel.dart';

import 'package:http/http.dart' as http;

class Service2 {
  // Future<List<Post>?

  Future<List<Post>?> getPost() async {
    try {
      var url = Uri.parse(
          'https://theaddresspmsrestapispring-production.up.railway.app/api/signUps');
      var response =
          await http.get(url, headers: {"Content-type": "application/json"});
      print("-------------------------------");
      print(response.body);
      if (response.statusCode == 200) {
        List<Post> _model = postsFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deletePosts(int? id) async {
    try {
      var url = Uri.parse(
          "https://theaddresspmsrestapispring-production.up.railway.app/api/signUps" +
              '${id}');
      var response = await http.delete(url);

      // Response res = await delete('$apiUrl/$id');

      if (response.statusCode == 200) {
        print("Case deleted");
      } else {
        throw "Failed to delete a case.";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Post>?> createPost(Post posts) async {
    var url = Uri.parse(
        'https://theaddresspmsrestapispring-production.up.railway.app/api/signUps');
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: jsonEncode(posts),
    );
    if (response.statusCode == 200) {
      print("Update submitted");
    } else {
      throw Exception("Failed to load post");
    }
  }
}
