import 'package:dars_73/bloc/chats/chat_bloc.dart';
import 'package:dars_73/bloc/chats/chat_event.dart';
import 'package:dars_73/bloc/chats/chat_state.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/main.dart';
import 'package:dars_73/ui/screens/contacts.dart';
import 'package:dars_73/ui/screens/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  ContactModel myContactDatas;
  HomeScreen({super.key, required this.myContactDatas});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(GetAllMyChatsChatEvent(widget.myContactDatas));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Chat Users"),
        actions: [
          IconButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                await pref.setString("user", false.toString());
                await pref.setString("userId", '');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RestartApp()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is LoadingChatState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (state is ErrorChatState) {
            return Center(
              child: Text("${state.message}"),
            );
          }

          if (state is LoadedChatState) {
            print(state.chats);
            return state.chats.length != 0
                ? ListView.builder(
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) {
                      final chat = state.myContactDatas.contactId !=
                              state.chats[index].user1.contactId
                          ? state.chats[index].user1
                          : state.chats[index].user2;
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                chat.imageUrl,
                              ),
                            ),
                          ),
                        ),
                        title: Text("${chat.contactName}"),
                        trailing: Icon(Icons.message),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowMessage(
                                chat: state.chats[index],
                                myModel: widget.myContactDatas,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Center(
                    child: Text("Hozirda chatlar mavjud emas"),
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
          if (value == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContactsScreen(model: widget.myContactDatas)));
          }
        },
      ),
    );
  }
}
