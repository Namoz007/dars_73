import 'dart:convert';

import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/models/message_model.dart';
import 'package:http/http.dart' as http;

class ChatServices{
  final _api = "https://chat-719e0-default-rtdb.firebaseio.com/chat";
  
  Future<List<ChatModel>> getAllMyChats() async{
    List<ChatModel> _chats = [];
    final response = await http.get((Uri.parse("${_api}.json")));
    if(jsonDecode(response.body) != null || jsonDecode(response.body).toString() != "null"){
      final a = jsonDecode(response.body) as Map<String,dynamic>;
      print("bu a $a");
      List<String> keys = a.keys.toList();
      for(int i = 0;i < keys.length;i++) {
        List<MessageModel> messages = [];
        if(a[keys[i]]['messages'] != null){
          List<String> messageKeys = a[keys[i]]['messages'].keys.toList();
          for(int j = 0; j < messageKeys.length;j++){
            messages.add(MessageModel(messageId: a[keys[i]]['messages'][messageKeys[j]]['messageId'], messageText: a[keys[i]]['messages'][messageKeys[j]]['messageText'], isFile: a[keys[i]]['messages'][messageKeys[j]]['isFile'], createdTime: DateTime.parse(a[keys[i]]['messages'][messageKeys[j]]['createdTime']), contactId: a[keys[i]]['messages'][messageKeys[j]]['contactId'], status: bool.parse(a[keys[i]]['messages'][messageKeys[j]]['status'].toString())));
          }
        }
        _chats.add(ChatModel(user1: ContactModel.fromJson(a[keys[i]]['user1'], a[keys[i]]['user1']['contactId']), user2: ContactModel.fromJson(a[keys[i]]['user2'], a[keys[i]]['user2']['contactId']), messages: messages, chatUrl: a[keys[i]]['chatUrl']));
      }
    }
    return _chats;
  }


  Future<void> createNewChat(ChatModel chat) async{
    final response = await http.post(Uri.parse("${_api}.json"),body: jsonEncode(chat.toMap()));
    print("bu response");
    // return chat;
  }
}