import 'package:bloc/bloc.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_event.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_state.dart';
import 'package:dars_73/services/chat_services.dart';

import '../../data/repositories/contacts_repositories.dart';

class ContactBloc extends Bloc<ContactEvent,ContactState>{
  final ContactsRepositories _repositories;
  final ChatServices _services;

  ContactBloc({required ContactsRepositories repo,required ChatServices services}) : _repositories = repo,_services = services,super(InitialContactState()){
    on<GetAllContactEvent>(_getAllContacts);
    on<GetContactEvent>(_getContact);
    on<GetContactChatContactEvent>(_getChat);
  }


  void _getAllContacts(GetAllContactEvent event,emit) async{
    emit(LoadingContactState());
    emit(LoadedContactState(await _repositories.getAllContacts()));
  }

  void _getChat(GetContactChatContactEvent event,emit) async{
    emit(LoadingContactState());
    bool isFind = false;
    final chats = await _services.getAllMyChats();
    for(int i = 0; i < chats.length;i++){
      if(chats[i].user1.contactId == event.myModel.contactId || chats[i].user2.contactId == event.myModel.contactId){
        isFind = true;
        emit(ChatContactState(chats[i],event.chatModel));
      }
    }

    if(!isFind){
      emit(ChatContactState(null,event.chatModel));
    }
  }

  void _getContact(GetContactEvent event,emit){}
}