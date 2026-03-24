import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_app/model/postModel.dart';
import 'package:teste_app/types/postStatus.dart';

class PostService {
  final String baseUrl;

  PostService(this.baseUrl);

  Future<List<PostModel>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => PostModel.fromMap(e)).toList();
    } else {
      List<PostModel> PostModelLista = [];
      return PostModelLista.map(
        (e) => PostModel.fromMap(e as Map<String, dynamic>),
      ).toList();
    }
  }
}
