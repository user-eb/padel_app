import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:padel_app/models/Chat.dart';
import 'package:padel_app/models/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatEvent extends Equatable {
  ChatEvent([List props = const []]);
}


//triggered to fetch list of chats
class FetchChatListEvent extends ChatEvent {
  @override
  String toString() => 'FetchChatListEvent';

  List<Object> get props => [];
}


//triggered when stream containing list of chats has new data
class ReceivedChatsEvent extends ChatEvent {
  final List<Chat> chatList;

  ReceivedChatsEvent(this.chatList);

  @override
  String toString() => 'ReceivedChatsEvent';

  List<Object> get props => [chatList];

}

//triggered to get details of currently open conversation
class FetchConversationDetailsEvent extends ChatEvent {
  final Chat chat;

  FetchConversationDetailsEvent(this.chat) : super([chat]);

  @override
  String toString() => 'FetchConversationDetailsEvent';

  List<Object> get props => [chat];

}

//triggered to fetch messages of chat, this will also keep a subscription for new messages
class FetchMessagesEvent extends ChatEvent {
  final Chat chat;
  FetchMessagesEvent(this.chat,) : super([chat]);

  @override
  String toString() => 'FetchMessagesEvent';

  List<Object> get props => [chat];

}
//triggered to fetch messages of chat
class FetchPreviousMessagesEvent extends ChatEvent {
  final Chat chat;
  final Message lastMessage;
  FetchPreviousMessagesEvent(this.chat,this.lastMessage) : super([chat,lastMessage]);

  @override
  String toString() => 'FetchPreviousMessagesEvent';

  List<Object> get props => [chat, lastMessage];

}

//triggered when messages stream has new data
class ReceivedMessagesEvent extends ChatEvent {
  final List<Message> messages;
  final String username;
  ReceivedMessagesEvent(this.messages, this.username) : super([messages, username]);

  @override
  String toString() => 'ReceivedMessagesEvent';

  List<Object> get props => [messages, username];

}

//triggered to send new text message
class SendTextMessageEvent extends ChatEvent {
  final String message;

  SendTextMessageEvent(this.message) : super([message]);

  @override
  String toString() => 'SendTextMessageEvent {message: $message}';

  List<Object> get props => [message];
}

//triggered to send attachment
class SendAttachmentEvent extends ChatEvent {
  final String chatId;
  final File file;
  final FileType fileType;

  SendAttachmentEvent(this.chatId, this.file, this.fileType)
      : super([chatId, file, fileType]);

  @override
  String toString() => 'SendAttachmentEvent';

  List<Object> get props => [chatId, file, fileType];
}

//triggered on page change
class PageChangedEvent extends ChatEvent {
  final int index;
  final Chat activeChat;
  PageChangedEvent(this.index, this.activeChat) : super([index, activeChat]);

  @override
  String toString() => 'PageChangedEvent {index: $index, activeChat: $activeChat}';

  List<Object> get props => [index, activeChat];
}

class RegisterActiveChatEvent extends ChatEvent{
  final String activeChatId;
  RegisterActiveChatEvent(this.activeChatId);
  @override
  String toString() => 'RegisterActiveChatEvent { activeChatId : $activeChatId }';

  List<Object> get props => [activeChatId];
}

// hide/show emojikeyboard
class ToggleEmojiKeyboardEvent extends ChatEvent{
  final bool showEmojiKeyboard;

  ToggleEmojiKeyboardEvent(this.showEmojiKeyboard);

  @override
  String toString() => 'ToggleEmojiKeyboardEvent';

  List<Object> get props => [showEmojiKeyboard];
}