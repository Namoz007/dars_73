import 'dart:convert';

import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactsServices{
  final _api = "https://chat-719e0-default-rtdb.firebaseio.com/contacts";

  Future<List<ContactModel>> getAllContacts() async{
    List<ContactModel> _contacts = [];
    final response = await http.get(Uri.parse("${_api}.json"));
    print("bu response ${response.body}");
    final a =  jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = a.keys.toList();
    for(int i = 0; i < keys.length;i++)
      _contacts.add(ContactModel.fromJson(a[keys[i]], a[keys[i]]['contactId']));

    print("bu contacts ${_contacts}");

    return _contacts;
  }
}