import 'package:dars_73/data/models/contact_model.dart';

sealed class ContactEvent{}

final class GetAllContactEvent extends ContactEvent{}

final class GetContactEvent extends ContactEvent{}

final class GetContactChatContactEvent extends ContactEvent{
  ContactModel myModel;
  ContactModel chatModel;

  GetContactChatContactEvent(this.myModel,this.chatModel);
}