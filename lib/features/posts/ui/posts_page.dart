import 'package:bloc_api/features/posts/bloc/posts_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBlocBloc _postsBlocBloc = PostsBlocBloc();

  @override
  void initState() {
    _postsBlocBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBlocBloc, PostsBlocState>(
        bloc: _postsBlocBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;

              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            color: Colors.amber),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.posts[index].title),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
