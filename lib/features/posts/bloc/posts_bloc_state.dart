part of 'posts_bloc_bloc.dart';

sealed class PostsBlocState {}

abstract class PostsActionState extends PostsBlocState {}

final class PostsBlocInitial extends PostsBlocState {}

final class PostsFetchingLoadingState extends PostsBlocState {}

final class PostsFetchingErrorState extends PostsBlocState {
  final String errorMessage;

  PostsFetchingErrorState({
    required this.errorMessage,
  });
}

final class PostFetchingSuccessfulState extends PostsBlocState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({
    required this.posts,
  });
}
