
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigState extends Equatable {
  ConfigState([List props = const []]);
}

class ConfigChangeState extends ConfigState{
  final String key;
  final bool value;
  ConfigChangeState(this.key,this.value): super([key,value]);

  @override
  List<Object> get props => [key, value];
}
class UnConfigState extends ConfigState{
  @override
  List<Object> get props => [];
}
class UpdatingProfilePictureState extends ConfigState{
  @override
  List<Object> get props => [];
}
class ProfilePictureChangedState extends ConfigState{
  final String profilePictureUrl;
  ProfilePictureChangedState(this.profilePictureUrl):super([profilePictureUrl]);
  @override
  String toString()=> 'ProfilePictureChangedState {profilePictureUrl: $profilePictureUrl}';

  @override
  List<Object> get props => [profilePictureUrl];
}
class RestartedAppState extends ConfigState{
  RestartedAppState():super([]);

  @override
  List<Object> get props => [];
}