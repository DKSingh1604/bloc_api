//BLOC TAKES AN EVENT AND EMITS A STATE

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:bloc_api/features/posts/repos/posts_repo.dart';

part 'posts_bloc_event.dart';
part 'posts_bloc_state.dart';

class PostsBlocBloc extends Bloc<PostsBlocEvent, PostsBlocState> {
  PostsBlocBloc() : super(PostsBlocInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsBlocState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();

    emit(PostFetchingSuccessfulState(posts: posts));
  }

  Future<void> postAddEvent(
      PostAddEvent event, Emitter<PostsBlocState> emit) async {
    bool success = await PostsRepo.addPosts();
    print(success);
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostAdditionErrorState());
    }
  }
}
