import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_app/components/postInputIn/postInpuIn.dart';
import 'package:teste_app/components/postInputIn/validator.dart';
import 'package:teste_app/controller/post_controler.dart';
import 'package:teste_app/pages/cadastro/index.dart';
import 'package:teste_app/pages/inicio/data/inicio_cubit.dart';
import 'package:teste_app/pages/cadastro/data/post_state.dart';

class PageIndex extends StatefulWidget {
  const PageIndex({super.key});

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  late PostController controller;

  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> posts = [];

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = PostController(context: context, fetchDataFunction: loadPosts);

    loadPosts();
  }

  Future<void> loadPosts() async {
    final data = controller.fetchData();
    setState(() {
      posts = data;
    });
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      context.read<PostInitCubit>().postOk(
        tituloController.text,
        descricaoController.text,
      );
      final post = context.read<PostInitCubit>().state.content;

      await controller.createPost(post: post!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(automaticallyImplyLeading: false),
      body: BlocListener<PostInitCubit, PostState>(
        listener: (context, state) {
          final content = state.content;

          if (content!.titulo != null) {
            showDialog(
              context: context,
              builder: (dContext) => AlertDialog(
                title: Text('Salvar post'),
                content: Text('Deseja salvar?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dContext);
                      tituloController.clear();
                      descricaoController.clear();
                      context.read<PostInitCubit>().limpar();
                      FocusScope.of(context).unfocus();
                    },
                    child: Text("SIM"),
                  ),
                ],
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PostInpuIn(
                  label: "Título",
                  controller: tituloController,
                  validator: (value) {
                    return Validators.validaTitulo(value);
                  },
                ),
                SizedBox(height: 16),

                PostInpuIn(
                  label: "Descrição",
                  controller: descricaoController,
                  validator: (value) {
                    return Validators.validaDescricao(value, 10);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: submit, child: Text("Enviar")),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PostPage()),
                    );
                  },
                  child: Text("Ver posts"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
