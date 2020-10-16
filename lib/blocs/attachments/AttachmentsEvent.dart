import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttachmentsEvent extends Equatable {
  AttachmentsEvent([List props = const []]);
}
class FetchAttachmentsEvent extends AttachmentsEvent{
  final FileType fileType;
  final String chatId;
  FetchAttachmentsEvent(this.chatId,this.fileType): super([chatId,fileType]);

  @override
  String toString() => 'FetchAttachmentsEvent { chatId : $chatId fileType : $fileType }';

  List<Object> get props => [fileType, chatId];
}