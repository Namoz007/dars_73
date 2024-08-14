import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/models/message_model.dart';

class ChatModel {
  ContactModel user1;
  ContactModel user2;
  List<MessageModel> messages;
  String chatUrl;

  ChatModel({
    required this.user1,
    required this.user2,
    required this.messages,
    required this.chatUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'user1': user1.toMap(), // Assuming ContactModel has a toMap method
      'user2': user2.toMap(), // Assuming ContactModel has a toMap method
      'messages': messages.map((message) => message.toMap()).toList(), // Assuming MessageModel has a toMap method
      'chatUrl': chatUrl,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> mp) {
    return ChatModel(
      user1: ContactModel.fromJson(mp['user1'], mp['user1']['contactId']),
      user2: ContactModel.fromJson(mp['user2'], mp['user2']['contactId']),
      messages: mp['messages'] == null ? [] : mp['messages'].map((message) => MessageModel.fromJson(message)).toList(), // Assuming MessageModel has a fromJson method
      chatUrl: mp['chatUrl'],
    );
  }
}

