part of 'posts_bloc_bloc.dart';

@immutable
sealed class PostsBlocEvent {}

class PostsInitialFetchEvent extends PostsBlocEvent {}
