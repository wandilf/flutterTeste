import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:teste_app/model/postModel.dart';
import 'package:teste_app/services/post_service.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostService service;
  final Box hiveBox;

  PostCubit({required this.hiveBox, required this.service})
    : super(PostInitial());

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());

      final apiPosts = await service.getPosts();

      //   for (var post in apiPosts) {
      //     await hiveBox.add(post.toMap());
      //   }

      final newApiPosts = apiPosts
          .map((key) {
            return {'titulo': key.titulo, 'descricao': key.descricao};
          })
          .toList()
          .reversed
          .toList();

      final data = hiveBox.keys
          .map((key) {
            final posts = hiveBox.get(key);
            return {
              'key': key,
              'titulo': posts['titulo'],
              'descricao': posts['descricao'],
            };
          })
          .toList()
          .reversed
          .toList();

      final combined = [...data, ...newApiPosts];

      emit(PostLoaded(combined));
    } catch (e) {
      emit(PostError('Erro ao carregar dados'));
    }
  }

  Future<void> createPost(PostModel post) async {
    try {
      await hiveBox.add(post.toMap());
      fetchPosts();
    } catch (e) {
      emit(PostError('Erro ao criar post'));
    }
  }
}
