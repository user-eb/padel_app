import 'package:equatable/equatable.dart';
import 'package:padel_app/models/Contact.dart';
import 'package:padel_app/utils/Exceptions.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsState extends Equatable {
  ContactsState([List props = const []]);
}

class InitialContactsState extends ContactsState {
  @override
  String toString() => 'InitialContactsState';

  List<Object> get props => [];
}
//Fetching contacts from firebase
class FetchingContactsState extends ContactsState{
  @override
  String toString() => 'FetchingContactsState';

  List<Object> get props => [];
}
//contacts fetched successfully
class FetchedContactsState extends ContactsState {
  final List<Contact> contacts;
  FetchedContactsState(this.contacts): super([contacts]);
  @override
  String toString() => 'FetchedContactsState';

  List<Object> get props => [contacts];
}

// Add Contact Clicked, show progressbar
class AddContactProgressState extends ContactsState {
  @override
  String toString() => 'AddContactProgressState';

  List<Object> get props => [];
}

// Add contact success
class AddContactSuccessState extends ContactsState {
  @override
  String toString() => 'AddContactSuccessState';

  List<Object> get props => [];
}

// Add contact failed
class AddContactFailedState extends ContactsState {
  final PadelException exception;
  AddContactFailedState(this.exception): super([exception]);
  @override
  String toString() => 'AddContactFailedState';

  List<Object> get props => [];
}


// Handle errors
class ErrorState extends ContactsState {
  final PadelException exception;
  ErrorState(this.exception): super([exception]);
  @override
  String toString() => 'ErrorState';

  List<Object> get props => [];
}