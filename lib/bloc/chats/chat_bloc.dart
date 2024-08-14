import 'package:bloc/bloc.dart';
import 'package:dars_73/bloc/chats/chat_event.dart';
import 'package:dars_73/bloc/chats/chat_state.dart';
import 'package:dars_73/data/repositories/chat_repositories.dart';

class ChatBloc extends Bloc<ChatEvent,ChatState>{
  final ChatRepositories _repositories;

  ChatBloc({required ChatRepositories repo}) : _repositories = repo,super(InitialChatState()){
    on<GetAllMyChatsChatEvent>(_getAllMyChats);
    on<CreateChatEvent>(_createNewChat);
  }

  void _getAllMyChats(GetAllMyChatsChatEvent event,emit) async{
    emit(LoadingChatState());
    emit(LoadedChatState(chats: await _repositories.getAllChats(), myContactDatas: event.myContactModel));
  }

  void _createNewChat(CreateChatEvent event,emit) async{

  }
}