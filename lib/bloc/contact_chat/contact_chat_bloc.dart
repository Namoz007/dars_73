import 'package:bloc/bloc.dart';
import 'package:dars_73/bloc/contact_chat/contact_chat_event.dart';
import 'package:dars_73/bloc/contact_chat/contact_chat_state.dart';
import 'package:dars_73/data/repositories/contact_chat_repositories.dart';

class ContactChatBloc extends Bloc<ContactChatEvent,ContactChatState>{
  final ContactChatRepositories _repositories;
  ContactChatBloc({required ContactChatRepositories repo}) : _repositories = repo,super(InitialContactChatState()){
    on<CreateNewContactChatEvent>(_createNewChat);
    on<GetContactChatEvent>(_getContactChat);
    on<WriteContactChatEvent>(_writeMessageToChat);
  }

  void _writeMessageToChat(WriteContactChatEvent event,emit) async{
    _repositories.writeMessage(event.chatUrl, event.messageModel);
  }

  void _getContactChat(GetContactChatEvent evemt,emit) async{
    emit(LoadingContactChatState());
    emit(LoadedContactChatState(await _repositories.getChatMessages(evemt.chatUrl)));
  }

  void _createNewChat(CreateNewContactChatEvent event,emit) async{
    emit(LoadingContactChatState());
    await _repositories.createNewContactChat(event.chatModel);
    emit(LoadedContactChatState(await _repositories.getChatMessages(event.chatModel.chatUrl)));
  }
}