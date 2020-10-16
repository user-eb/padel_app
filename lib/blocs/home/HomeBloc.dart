import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:padel_app/repositories/ChatRepository.dart';
import './Bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ChatRepository chatRepository;

  HomeBloc([this.chatRepository]) : assert(chatRepository != null), super(InitialHomeState());

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {
    print(event);
    if (event is FetchHomeChatsEvent) {
      yield FetchingHomeChatsState();
      chatRepository.getConversations().listen(
              (conversations) => add(ReceivedChatsEvent(conversations)));
    }
    if (event is ReceivedChatsEvent) {
      yield FetchingHomeChatsState();
      yield FetchedHomeChatsState(event.conversations);
    }
  }

}