import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teste_app/model/postModel.dart';

class PostController {
  final BuildContext context;
  final Function fetchDataFunction;

  PostController({required this.context, required this.fetchDataFunction});

  final hiveBox = Hive.box('posts');

  List<Map<String, dynamic>> fetchData() {
    return hiveBox.keys
        .map((key) {
          final posts = hiveBox.get(key);
          return {
            'key': key,
            'titulo': posts['titulo'],
            'descricao': posts['descricao'],
            'status': posts['status'],
          };
        })
        .toList()
        .reversed
        .toList();
  }

  Future<void> createPost({required PostModel post}) async {
    try {
      await hiveBox.add(post.toMap());
      await fetchDataFunction();
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<void> listarDadosHive() async {
    // 1. Abrir a box (verifique se já não foi aberta no main)

    // 2. Obter todas as chaves
    print('--- Iniciando Listagem ---');

    // 3. Iterar sobre as chaves e pegar os valores
    for (var key in hiveBox.keys) {
      var dado = hiveBox.get(key);
      print('Chave: $key, Valor: $dado');
    }

    print('--- Fim da Listagem ---');
  }
}
