import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_app/model/postModel.dart';
import 'package:teste_app/pages/cadastro/data/post_state.dart';
import 'package:teste_app/types/postStatus.dart';

class PostInitCubit extends Cubit<PostState> {
  PostInitCubit() : super(PostState());

  void postOk(String titulo, String descricao) {
    emit(
      state.copyWith(
        content: PostModel(
          titulo: titulo,
          descricao: descricao,
          aviso: "Operação realizada com sucesso",
          status: postStatus.ok,
        ),
      ),
    );
  }

  void postErro(String titulo, String descricao) {
    emit(
      state.copyWith(
        content: PostModel(
          titulo: titulo,
          descricao: descricao,
          aviso: "Erro ao realizar operação",
          status: postStatus.erro,
        ),
      ),
    );
  }

  void limpar() {
    emit(
      state.copyWith(
        content: PostModel(
          titulo: null,
          descricao: null,
          aviso: "",
          status: postStatus.novo,
        ),
      ),
    );
  }
}
