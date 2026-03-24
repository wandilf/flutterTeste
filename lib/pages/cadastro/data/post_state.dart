import 'package:teste_app/model/postModel.dart';

class PostState {
  late final PostModel? content;

  PostState({this.content});

  PostState copyWith({PostModel? content}) {
    return PostState(content: content ?? this.content);
  }
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Map<String, dynamic>> posts;

  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
