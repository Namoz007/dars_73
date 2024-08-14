import 'package:dars_73/bloc/chats/chat_event.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_bloc.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_event.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_state.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/main.dart';
import 'package:dars_73/ui/screens/home_screen.dart';
import 'package:dars_73/ui/screens/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsScreen extends StatefulWidget {
  ContactModel model;
  ContactsScreen({super.key, required this.model});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactBloc>().add(GetAllContactEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Contacts"),
      ),
      body:  BlocConsumer<ContactBloc, ContactState>(
        listener: (context,state){
          if(state is ChatContactState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => state.chat != null ? ShowMessage(chat: state.chat,myModel: widget.model,) : ShowMessage(myModel: widget.model,chatModel: state.chatUserModel,)));
          }
        },
        builder: (context, state) {
          if (state is LoadingContactState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (state is ErrorContactState) {
            return Center(
              child: Text("${state.message}"),
            );
          }

          if (state is LoadedContactState) {
            return state.contacts.length == 1 &&
                    state.contacts[0].contactId == widget.model.contactId
                ? const Center(
                    child: Text("Hozirda kontaktlar mavjud emas"),
                  )
                : ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.contacts[index];
                      return contact.contactId != widget.model.contactId
                          ? ListTile(
                        onTap: (){
                          context.read<ContactBloc>().add(GetContactChatContactEvent(widget.model,contact));
                        },
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(contact.imageUrl),
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                    )),
                              ),
                              title: Text(
                                "${contact.contactName}",
                              ),
                              trailing: Icon(
                                Icons.message,
                              ),
                            )
                          : SizedBox();
                    },
                  );
          }



          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: "Contacts",
          ),
        ],
        onTap: (value) {
          if (value == 0) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(myContactDatas: widget.model)));
          }
        },
      ),
    );
  }
}
