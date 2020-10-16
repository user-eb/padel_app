import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:padel_app/providers/AuthenticationProvider.dart';
import 'package:padel_app/providers/BaseProviders.dart';
import 'package:padel_app/repositories/BaseRepository.dart';

class AuthenticationRepository extends BaseRepository {

  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<firebase.User> signInWithGoogle() =>
      authenticationProvider.signInWithGoogle();

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  Future<firebase.User> getCurrentUser() =>
      authenticationProvider.getCurrentUser();

  Future<bool> isLoggedIn() => authenticationProvider.isLoggedIn();

  @override
  void dispose() {
    authenticationProvider.dispose();
  }
}