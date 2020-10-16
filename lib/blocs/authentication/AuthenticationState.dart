import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:padel_app/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]);
}

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class AuthInProgress extends AuthenticationState{
  @override
  String toString() => 'AuthInProgress';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState{
  final firebase.User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';

  @override
  List<Object> get props => [];
}

class PreFillData extends AuthenticationState{
  final User user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';

  @override
  List<Object> get props => [user];
}

class UnAuthenticated extends AuthenticationState{
  @override
  String toString() => 'UnAuthenticated';

  @override
  List<Object> get props => [];
}

class ReceivedProfilePicture extends AuthenticationState{
  final File file;
  ReceivedProfilePicture(this.file);
  @override toString() => 'ReceivedProfilePicture';

  @override
  List<Object> get props => [file];
}

class ProfileUpdateInProgress extends AuthenticationState{
  @override
  String toString() => 'ProfileUpdateInProgress';

  @override
  List<Object> get props => [];
}

class ProfileUpdated extends AuthenticationState{
  @override
  String toString() => 'ProfileComplete';

  @override
  List<Object> get props => [];
}