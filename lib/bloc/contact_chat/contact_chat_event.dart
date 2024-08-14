import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/message_model.dart';

sealed class ContactChatEvent{}

final class CreateNewContactChatEvent extends ContactChatEvent{
  ChatModel chatModel;

  CreateNewContactChatEvent(this.chatModel);
}

final class GetContactChatEvent extends ContactChatEvent{
  String chatUrl;

  GetContactChatEvent(this.chatUrl);
}

final class WriteContactChatEvent extends ContactChatEvent{
  String chatUrl;
  MessageModel messageModel;

  WriteContactChatEvent({required this.chatUrl,required this.messageModel,});
}