import 'package:equatable/equatable.dart';
import 'package:padel_app/models/Contact.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsEvent extends Equatable {
  ContactsEvent([List props = const []]);
}

// Fetch the contacts from firebase
class FetchContactsEvent extends ContactsEvent{
  @override
  String toString() => 'FetchContactsEvent';

  List<Object> get props => [];
}

// Dispatch received contacts from stream
class ReceivedContactsEvent extends ContactsEvent{
  final List<Contact> contacts;
  ReceivedContactsEvent(this.contacts) : super([contacts]);
  @override
  String toString() => 'ReceivedContactsEvent';

  List<Object> get props => [contacts];
}

//Add a new contact
class AddContactEvent extends ContactsEvent {
  final String username;
  AddContactEvent({@required this.username}): super([username]);
  @override
  String toString() => 'AddContactEvent';

  List<Object> get props => [username];
}

