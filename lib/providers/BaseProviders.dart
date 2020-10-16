import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:padel_app/models/Chat.dart';
import 'package:padel_app/models/Contact.dart';
import 'package:padel_app/models/Conversation.dart';
import 'package:padel_app/models/Message.dart';
import 'package:padel_app/models/User.dart' as User;

abstract class BaseProvider{
  void dispose();
}
abstract class BaseAuthenticationProvider extends BaseProvider{
  Future<firebase.User> signInWithGoogle();
  Future<void> signOutUser();
  Future<firebase.User> getCurrentUser();
  Future<bool> isLoggedIn();
}

abstract class BaseUserDataProvider extends BaseProvider{
  Future<User.User> saveDetailsFromGoogleAuth(firebase.User user);
  Future<User.User> saveProfileDetails(String profileImageUrl, int age, String username);
  Future<bool> isProfileComplete();
  Stream<List<Contact>> getContacts();
  Future<void> addContact(String username);
  Future<User.User> getUser(String username);
  Future<String> getUidByUsername(String username);
  Future<void> updateProfilePicture(String profilePictureUrl);
}

abstract class BaseStorageProvider extends BaseProvider{
  Future<String> uploadFile(File file, String path);
}

abstract class BaseChatProvider extends BaseProvider{
  Stream<List<Conversation>> getConversations();
  Stream<List<Message>> getMessages(String chatId);
  Future<List<Message>> getPreviousMessages(String chatId, Message prevMessage);
  Future<List<Message>> getAttachments(String chatId, int type);
  Stream<List<Chat>> getChats();
  Future<void> sendMessage(String chatId, Message message);
  Future<String> getChatIdByUsername(String username);
  Future<void> createChatIdForContact(User.User user);
}
abstract class BaseDeviceStorageProvider extends BaseProvider{
  Future<File> getThumbnail(String videoUrl);
}