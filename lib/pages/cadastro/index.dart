import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:teste_app/pages/cadastro/data/post_cubit.dart';
import 'package:teste_app/pages/cadastro/data/post_state.dart';
import 'package:teste_app/pages/inicio/index.dart';
import 'package:teste_app/services/post_service.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(
        hiveBox: Hive.box('posts'),
        service: PostService('https://jsonplaceholder.typicode.com/posts'),
      )..fetchPosts(),
      child: const _PostView(),
    );
  }
}

class _PostView extends StatelessWidget {
  const _PostView();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final item = state.posts[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 66, 66, 66),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    title: Text(
                      item['titulo'],
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    subtitle: Text(
                      item['descricao'],
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }

          if (state is PostError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PageIndex()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
