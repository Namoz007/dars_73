import 'dart:math';

import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositories {
  final AuthServices _services;
  ContactModel? model;

  AuthRepositories({
    required AuthServices servic,
  }) : _services = servic;

  Future<ContactModel?> login(String contactName) async {
    final response = await _services.login(contactName);
    print("bu response ${response}");
    if(response != null){
      model = response;
      final pref = await SharedPreferences.getInstance();
      await pref.setString("userId", model!.contactId);
      await pref.setString("user", true.toString());
      return model!;
    }
  }

  Future<ContactModel?> registration(
      String contactName, String contactLastName, String contactImgUrl) async {
    final response = await _services.registration(contactName, contactLastName, contactImgUrl);
    print("bu response ${response}");
    if(response != null){
      model = ContactModel(contactId: response, contactLastName: contactLastName, contactName: contactName, isOnline: false, imageUrl: contactImgUrl, lastOnlineTime: DateTime.now());
      final pref = await SharedPreferences.getInstance();
      pref.setString("user", true.toString());
      pref.setString("userId", model!.contactId);
      return model!;
    }
  }
}
