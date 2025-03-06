import 'dart:convert';

import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      );

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      return [];
      print(e.toString());
    }
  }

  static Future<bool> addPosts() async {
    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
          body: {
            "title": "I am Flutter Developer",
            "body": "I am ready to work",
            "userId": "34",
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
      print(e.toString());
    }
  }
}
