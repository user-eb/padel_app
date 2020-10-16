import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:padel_app/models/User.dart';
import 'package:padel_app/repositories/ChatRepository.dart';
import 'package:padel_app/repositories/UserDataRepository.dart';
import 'package:padel_app/utils/Exceptions.dart';
import './Bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  UserDataRepository userDataRepository;
  ChatRepository chatRepository;
  StreamSubscription subscription;

  // ContactsBloc({this.userDataRepository, this.chatRepository})
  //     : assert(userDataRepository != null),
  //       assert(chatRepository != null);
  //
  // @override
  // ContactsState get initialState => InitialContactsState();

  ContactsBloc([this.userDataRepository, this.chatRepository])
      : assert(chatRepository != null),
        assert(userDataRepository != null),
        assert(chatRepository != null),
        super(InitialContactsState());

  @override
  Stream<ContactsState> mapEventToState(
      ContactsEvent event,
      ) async* {
    if (event is FetchContactsEvent) {
      try {
        yield FetchingContactsState();
        subscription?.cancel();
        subscription = userDataRepository.getContacts().listen((contacts) => {
          print('dispatching $contacts'),
          add(ReceivedContactsEvent(contacts))
        });
      } on PadelException catch (exception) {
        print(exception.errorMessage());
        yield ErrorState(exception);
      }
    }
    if (event is ReceivedContactsEvent) {
      yield FetchedContactsState(event.contacts);
    }
    if (event is AddContactEvent) {
      userDataRepository.getUser(event.username);
      yield* mapAddContactEventToState(event.username);
    }

  }

  Stream<ContactsState> mapFetchContactsEventToState() async* {
    try {
      yield FetchingContactsState();
      subscription?.cancel();
      subscription = userDataRepository.getContacts().listen((contacts) => {
        print('dispatching $contacts'),
        add(ReceivedContactsEvent(contacts))
      });
    } on PadelException catch (exception) {
      print(exception.errorMessage());
      yield ErrorState(exception);
    }
  }

  Stream<ContactsState> mapAddContactEventToState(String username) async* {
    try {
      yield AddContactProgressState();
      await userDataRepository.addContact(username);
      User user = await userDataRepository.getUser(username);
      await chatRepository.createChatIdForContact(user);
      yield AddContactSuccessState();
    } on PadelException catch (exception) {
      print(exception.errorMessage());
      yield AddContactFailedState(exception);
    }
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}