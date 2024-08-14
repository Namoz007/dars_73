import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/services/chat_services.dart';

class ChatRepositories{
  final ChatServices _services;

  ChatRepositories({required ChatServices servic}) : _services = servic;

  Future<void> createNewChat(ChatModel chatModel) async{
    return await _services.createNewChat(chatModel);
  }

  Future<List<ChatModel>> getAllChats() async{
    return _services.getAllMyChats();
  }
}