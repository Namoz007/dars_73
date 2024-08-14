import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/models/message_model.dart';

sealed class ChatState{}


final class InitialChatState extends ChatState{}

final class LoadingChatState extends ChatState{}

final class LoadedChatState extends ChatState{
  List<ChatModel> chats;
  ContactModel myContactDatas;

  LoadedChatState({required this.chats,required this.myContactDatas,});
}

final class ErrorChatState extends ChatState{
  String message;

  ErrorChatState(this.message);
}