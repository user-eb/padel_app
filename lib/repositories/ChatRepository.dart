import 'dart:async';

import 'package:padel_app/models/Chat.dart';
import 'package:padel_app/models/Conversation.dart';
import 'package:padel_app/models/Message.dart';
import 'package:padel_app/models/User.dart';
import 'package:padel_app/providers/BaseProviders.dart';
import 'package:padel_app/providers/ChatProvider.dart';

import 'BaseRepository.dart';


class ChatRepository extends BaseRepository{
  BaseChatProvider chatProvider = ChatProvider();
  Stream<List<Conversation>> getConversations() => chatProvider.getConversations();
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<List<Message>> getMessages(String chatId) => chatProvider.getMessages(chatId);
  Future<List<Message>> getPreviousMessages(
      String chatId, Message prevMessage) =>
      chatProvider.getPreviousMessages(chatId, prevMessage);

  Future<List<Message>> getAttachments(String chatId, int type) => chatProvider.getAttachments(chatId, type);

  Future<void> sendMessage(String chatId, Message message)=>chatProvider.sendMessage(chatId, message);

  Future<String> getChatIdByUsername(String username) =>
      chatProvider.getChatIdByUsername(username);

  Future<void> createChatIdForContact(User user) =>
      chatProvider.createChatIdForContact(user);

  @override
  void dispose() {
    chatProvider.dispose();
  }
}