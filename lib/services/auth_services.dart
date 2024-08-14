import 'dart:convert';
import 'dart:math';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  static final _api = "https://chat-719e0-default-rtdb.firebaseio.com/contacts";

  static Future<ContactModel?> getMyContactModelService() async{
    final pref = await SharedPreferences.getInstance();
    String userId = pref.getString("userId").toString();
    final response = await http.get(Uri.parse("$_api.json"));
    final a = jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = a.keys.toList();
    for(int i = 0; i < keys.length;i++) {
      if (a[keys[i]]['contactId'] == userId) {
        return ContactModel.fromJson(a[keys[i]], a[keys[i]]['contactId']);
      }
    }
  }

  Future<ContactModel?> login(String contactName) async {
    ContactModel? model;
    final response = await http.get(Uri.parse("${_api}.json"));
    final a = jsonDecode(response.body) as Map<String,dynamic>;
    List<String> keys = a.keys.toList();
    for(int i  =0; i < keys.length;i++) {
      if (a[keys[i]]['contactName'].toString() == contactName) {
        model = ContactModel.fromJson(a[keys[i]], keys[i]);
        print("name ${model.contactName}");
      }
    }
    return model;
  }

  Future<String?> registration(String contactName,String contactLastName, String imgUrl) async {
    final pref = await SharedPreferences.getInstance();
    try {
      final model = ContactModel(contactId: '', contactLastName: contactLastName, contactName: contactName, isOnline: false, imageUrl: imgUrl, lastOnlineTime: DateTime.now());
      final response = await http.post(Uri.parse("${_api}.json"),body: jsonEncode(model.toMap()));
      await http.patch(Uri.parse("${_api}/${jsonDecode(response.body)['name']}.json"),body: jsonEncode({"contactId": jsonDecode(response.body)['name']}));
      print("yangilandi");
      return jsonDecode(response.body)['name'];
    } catch (e) {
      print(e);
    }
  }
}
