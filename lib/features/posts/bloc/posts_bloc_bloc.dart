//BLOC TAKES AN EVENT AND EMITS A STATE

import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostsBlocInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsBlocState> emit) async {
    emit(PostsFetchingLoadingState());
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      );

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      print(posts);
      emit(PostFetchingSuccessfulState(posts: posts));
    } catch (e) {
      emit(PostsFetchingErrorState(errorMessage: e.toString()));
      print(e.toString());
    }
  }
}
