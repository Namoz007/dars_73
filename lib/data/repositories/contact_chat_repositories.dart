import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/message_model.dart';
import 'package:dars_73/services/contact_chat_services.dart';
import 'package:firebase_database/firebase_database.dart';

class ContactChatRepositories{
  final ContactChatServices _services;

  ContactChatRepositories({required ContactChatServices services}) : _services = services;

  Future<void> writeMessage(String chatUrl,MessageModel model) async{
    await _services.writeMessage(chatUrl, model);
  }

  Future<Stream<DatabaseEvent>> getChatMessages(String chatUrl) async{
    return _services.getDataStream();
  }

  Future<void> createNewContactChat(ChatModel chatModel) async{
    await _services.createNewContactChat(chatModel);
  }
}