part of 'posts_bloc_bloc.dart';

sealed class PostsBlocEvent {}

class PostsInitialFetchEvent extends PostsBlocEvent {}

class PostAddEvent extends PostsBlocEvent {}
