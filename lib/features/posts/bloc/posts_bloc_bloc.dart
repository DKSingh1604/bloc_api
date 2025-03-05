//BLOC TAKES AN EVENT AND EMITS A STATE

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostsBlocInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsBlocState> emit) async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('https://jsonplaceholder.typicode.com/guide/'),
      );
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
