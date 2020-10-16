import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:padel_app/models/Message.dart';
import 'package:padel_app/models/VideoWrapper.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttachmentsState extends Equatable {
  AttachmentsState([List props = const []]);
}

class InitialAttachmentsState extends AttachmentsState {
  List<Object> get props => [];
}

class FetchedAttachmentsState extends AttachmentsState{
  final List<Message> attachments;
  final FileType fileType;

  FetchedAttachmentsState(this.fileType,this.attachments): super([attachments, fileType]);

  @override
  String toString() => 'FetchedAttachmentsState { attachments : $attachments , fileType : $fileType}';

  List<Object> get props => [attachments, fileType];
}

class FetchedVideosState extends AttachmentsState{
  final List<VideoWrapper> videos;

  FetchedVideosState(this.videos): super([videos]);

  @override
  String toString() => 'FetchedVideosState { videos : $videos }';

  List<Object> get props => [videos];
}