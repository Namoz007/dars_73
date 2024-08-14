import 'package:firebase_database/firebase_database.dart';

sealed class ContactChatState{}

final class InitialContactChatState extends ContactChatState{}

final class LoadingContactChatState extends ContactChatState{}

final class LoadedContactChatState extends ContactChatState{
  Stream<DatabaseEvent> stream;

  LoadedContactChatState(this.stream);
}

final class ErrorContactChatState extends ContactChatState{
  String message;

  ErrorContactChatState(this.message);
}