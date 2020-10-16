import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]);
}

class AppLaunched extends AuthenticationEvent {
  @override
  String toString() => 'AppLaunched';

  @override
  List<Object> get props => [];
}

class ClickedGoogleLogin extends AuthenticationEvent {
  @override
  String toString() => 'ClickedGoogleLogin';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final firebase.User user;
  LoggedIn(this.user): super([user]);
  @override
  String toString() => 'LoggedIn';

  @override
  List<Object> get props => [user];
}

class PickedProfilePicture extends AuthenticationEvent{
  final File file;
  PickedProfilePicture(this.file): super([file]);
  @override
  String toString() => 'PickedProfilePicture';

  @override
  List<Object> get props => [file];
}

class SaveProfile extends AuthenticationEvent {
  final File profileImage;
  final int age;
  final String username;
  SaveProfile(this.profileImage, this.age, this.username): super([profileImage,age,username]);
  @override
  String toString() => 'SaveProfile';

  @override
  List<Object> get props => [profileImage, age, username];
}

class ClickedLogout extends AuthenticationEvent {
  @override
  String toString() => 'ClickedLogout';

  @override
  List<Object> get props => [];
}