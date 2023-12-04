import 'package:flutter_application_1/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var reponse = await client.get(uri);
    if (reponse.statusCode == 200) {
      var json = reponse.body;
      return postFromJson(json);
    }
  }
}
