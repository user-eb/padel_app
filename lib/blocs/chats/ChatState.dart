import 'package:equatable/equatable.dart';
import 'package:padel_app/models/Chat.dart';
import 'package:padel_app/models/Message.dart';
import 'package:padel_app/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatState extends Equatable {
  ChatState([List props = const []]);
}

class InitialChatState extends ChatState {
  List<Object> get props => [];
}

class FetchedChatListState extends ChatState {
  final List<Chat> chatList;

  FetchedChatListState(this.chatList) : super([chatList]);

  @override
  String toString() => 'FetchedChatListState';

  List<Object> get props => [chatList];
}
class FetchingMessageState extends ChatState{
  @override
  String toString() => 'FetchingMessageState';

  List<Object> get props => [];
}


class FetchedMessagesState extends ChatState {
  final List<Message> messages;
  final String username;
  final isPrevious;
  FetchedMessagesState(this.messages,this.username, {this.isPrevious}) : super([messages,username,isPrevious]);

  @override
  String toString() => 'FetchedMessagesState {messages: ${messages.length}, username: $username, isPrevious: $isPrevious}';

  List<Object> get props => [messages, username, isPrevious];
}

class ErrorState extends ChatState {
  final Exception exception;

  ErrorState(this.exception) : super([exception]);

  @override
  String toString() => 'ErrorState';

  List<Object> get props => [exception];
}

class FetchedContactDetailsState extends ChatState {
  final User user;
  final String username;
  FetchedContactDetailsState(this.user,this.username) : super([user,username]);

  @override
  String toString() => 'FetchedContactDetailsState';

  List<Object> get props => [user, username];
}

class PageChangedState extends ChatState {
  final int index;
  final Chat activeChat;
  PageChangedState(this.index, this.activeChat) : super([index, activeChat]);

  @override
  String toString() => 'PageChangedState';

  List<Object> get props => [index, activeChat];
}

class ToggleEmojiKeyboardState extends ChatState{
  final bool showEmojiKeyboard;

  ToggleEmojiKeyboardState(this.showEmojiKeyboard): super([showEmojiKeyboard]);

  @override
  String toString() => 'ToggleEmojiKeyboardState';

  List<Object> get props => [showEmojiKeyboard];
}