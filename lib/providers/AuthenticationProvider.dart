import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:padel_app/config/Constants.dart';
import 'package:padel_app/utils/SharedObjects.dart';
import 'BaseProviders.dart';

class AuthenticationProvider extends BaseAuthenticationProvider {

  final firebase.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthenticationProvider({firebase.FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn}):
        firebaseAuth= firebaseAuth ?? firebase.FirebaseAuth.instance, googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<firebase.User> signInWithGoogle() async {
    final GoogleSignInAccount account =
    await googleSignIn.signIn(); //show the goggle login prompt
    final GoogleSignInAuthentication authentication =
    await account.authentication; //get the authentication object
    final firebase.AuthCredential credential = firebase.GoogleAuthProvider.credential(
      //retreive the authentication credentials
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    await firebaseAuth.signInWithCredential(
        credential); //sign in to firebase using the generated credentials
    firebase.User firebaseUser = firebaseAuth.currentUser;
    await SharedObjects.prefs.setString(Constants.sessionUid, firebaseUser.uid);
    print('Session UID1 ${SharedObjects.prefs.getString(Constants.sessionUid)}');
    return firebaseUser; //return the firebase user created
  }

  @override
  Future<void> signOutUser() async {
    print('firebaseauth $firebaseAuth');
    await SharedObjects.prefs.clearSession();
    await Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]); // terminate the session
  }

  @override
  Future<firebase.User> getCurrentUser() async {
    return firebaseAuth.currentUser; //retrieve the current user
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser; //check if user is logged in or not
    return user != null;
  }

  @override
  void dispose() {}
}