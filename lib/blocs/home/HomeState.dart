import 'package:equatable/equatable.dart';
import 'package:padel_app/models/Conversation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([List props = const []]);
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class FetchingHomeChatsState extends HomeState{
  @override
  String toString() => 'FetchingHomeChatsState';

  @override
  List<Object> get props => [];
}
class FetchedHomeChatsState extends HomeState{
  final List<Conversation> conversations;

  FetchedHomeChatsState(this.conversations);

  @override
  String toString() => 'FetchedHomeChatsState';

  @override
  List<Object> get props => [conversations];
}