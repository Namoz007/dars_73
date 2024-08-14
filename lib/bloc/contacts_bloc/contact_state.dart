import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';

sealed class ContactState{}

final class InitialContactState extends ContactState{}

final class LoadingContactState extends ContactState{}

final class LoadedContactState extends ContactState{
  List<ContactModel> contacts;

  LoadedContactState(this.contacts);
}
final class ChatContactState extends ContactState{
  ChatModel? chat;
  ContactModel chatUserModel;

  ChatContactState(this.chat,this.chatUserModel);
}

final class ErrorContactState extends ContactState{
  String message;

  ErrorContactState(this.message);
}
