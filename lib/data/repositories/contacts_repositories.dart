import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/services/contacts_services.dart';

class ContactsRepositories{
  ContactsServices _services;

  ContactsRepositories({required ContactsServices services}) : _services = services;

  Future<List<ContactModel>> getAllContacts() async{
    return await _services.getAllContacts();
  }
}