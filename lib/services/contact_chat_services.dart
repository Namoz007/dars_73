import 'dart:convert';

import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class ContactChatServices{
  final _api = 'https://chat-719e0-default-rtdb.firebaseio.com/chat';
  
  Future<void> writeMessage(String url,MessageModel messageModel) async{
    await http.post(Uri.parse("${_api}/$url/messages.json"),body: jsonEncode(messageModel.toMap()));
  }

  Future<void> createNewContactChat(ChatModel chatModel) async{
    final response = await http.post(Uri.parse("${_api}.json"),body: jsonEncode(chatModel.toMap()));
    await http.patch(Uri.parse("${_api}/${jsonDecode(response.body)['name']}.json"),body: jsonEncode({
      "chatUrl": jsonDecode(response.body)['name'],
    }));
  }

  Stream<DatabaseEvent> getDataStream() {
    final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('chat');
    return _databaseReference.onValue;
  }
}