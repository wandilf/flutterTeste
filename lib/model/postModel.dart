import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:teste_app/types/postStatus.dart';

class PostModel extends Equatable {
  final String? titulo;
  final String? descricao;
  final String? aviso;
  final postStatus? status;

  const PostModel({
    required this.titulo,
    required this.descricao,
    this.status,
    this.aviso,
  });

  @override
  List<Object?> get props => [titulo, descricao, status, aviso];

  Map<String, dynamic> toMap() {
    return {'titulo': titulo, 'descricao': descricao, 'aviso': aviso};
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      titulo: map['title'],
      descricao: map['body'],
      aviso: 'aviso',
    );
  }
}
