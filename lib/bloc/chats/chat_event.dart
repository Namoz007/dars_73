import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';

sealed class ChatEvent{}

final class GetAllMyChatsChatEvent extends ChatEvent{
  ContactModel myContactModel;

  GetAllMyChatsChatEvent(this.myContactModel);
}

final class GetChatChatEvent extends ChatEvent{}

final class CreateChatEvent extends ChatEvent{
  ChatModel chatModel;
  ChatModel myContactDatas;

  CreateChatEvent(this.chatModel,this.myContactDatas,);
}