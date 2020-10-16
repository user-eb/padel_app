import 'package:equatable/equatable.dart';
import 'package:padel_app/models/Conversation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]);
}
class FetchHomeChatsEvent extends HomeEvent{
  @override
  String toString() => 'FetchHomeChatsEvent';

  @override
  List<Object> get props => [];
}
class ReceivedChatsEvent extends HomeEvent{
  final List<Conversation> conversations;
  ReceivedChatsEvent(this.conversations);

  @override
  String toString() => 'ReceivedChatsEvent';

  @override
  List<Object> get props => [conversations];

}