import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:padel_app/models/Contact.dart';
import 'package:padel_app/models/User.dart';
import 'package:padel_app/providers/BaseProviders.dart';
import 'package:padel_app/providers/UserDataProvider.dart';
import 'package:padel_app/repositories/BaseRepository.dart';

class UserDataRepository extends BaseRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<User> saveDetailsFromGoogleAuth(firebase.User user) =>
      userDataProvider.saveDetailsFromGoogleAuth(user);

  Future<User> saveProfileDetails(
      String uid, String profileImageUrl, int age, String username) =>
      userDataProvider.saveProfileDetails(profileImageUrl, age, username);

  Future<bool> isProfileComplete() => userDataProvider.isProfileComplete();

  Stream<List<Contact>> getContacts() => userDataProvider.getContacts();

  Future<void> addContact(String username) =>
      userDataProvider.addContact(username);

  Future<User> getUser(String username) => userDataProvider.getUser(username);
  Future<void> updateProfilePicture(String profilePictureUrl)=> userDataProvider.updateProfilePicture(profilePictureUrl);

  @override
  void dispose() {
    userDataProvider.dispose();
  }

}