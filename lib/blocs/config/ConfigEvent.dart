import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ConfigEvent extends Equatable {
  ConfigEvent([List props = const []]);
}

class ConfigValueChanged extends ConfigEvent{
  final String key;
  final bool value;
  ConfigValueChanged(this.key,this.value): super([key,value]);

  @override
  List<Object> get props => [key, value];
}

class UpdateProfilePicture extends ConfigEvent{
  final File file;
  UpdateProfilePicture(this.file): super([file]);
  @override
  String toString() => 'UpdateProfilePicture';

  @override
  List<Object> get props => [file];
}
class RestartApp extends ConfigEvent{
  @override
  String toString() => 'RestartApp';

  @override
  List<Object> get props => [];
}