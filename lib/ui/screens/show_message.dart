import 'dart:async';

import 'package:dars_73/bloc/contact_chat/contact_chat_bloc.dart';
import 'package:dars_73/bloc/contact_chat/contact_chat_event.dart';
import 'package:dars_73/bloc/contact_chat/contact_chat_state.dart';
import 'package:dars_73/data/models/chat_model.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMessage extends StatefulWidget {
  ChatModel? chat;
  ContactModel myModel;
  ContactModel? chatModel;

  ShowMessage({
    super.key,
    this.chat,
    required this.myModel,
    this.chatModel,
  });

  @override
  State<ShowMessage> createState() => _ShowMessageState();
}

class _ShowMessageState extends State<ShowMessage> {
  ContactModel? _chatUser;
  late StreamSubscription? _subscription;
  final textController = TextEditingController();
  bool isSend = false;

  @override
  void initState() {
    super.initState();
    if (widget.chat == null) {
      context.read<ContactChatBloc>().add(CreateNewContactChatEvent(ChatModel(
            user1: widget.myModel,
            user2: widget.chatModel!,
            messages: [],
            chatUrl: '',
          )));
    } else {
      context
          .read<ContactChatBloc>()
          .add(GetContactChatEvent(widget.chat!.chatUrl));
    }
    if (widget.chat != null) {
      if (widget.chat!.user1.contactId == widget.myModel.contactId) {
        _chatUser = widget.chat!.user2;
      } else if (widget.chat!.user2.contactId == widget.myModel.contactId) {
        _chatUser = widget.chat!.user1;
      }
    } else {
      _chatUser = widget.chatModel;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_chatUser!.contactName),
        actions: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(_chatUser!.imageUrl)),
              border: Border.all(color: Colors.black),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ContactChatBloc, ContactChatState>(
        builder: (context, state) {
          if (state is LoadingContactChatState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if (state is ErrorContactChatState) {
            return Center(
              child: Text("${state.message}"),
            );
          }

          if (state is LoadedContactChatState) {
            return StreamBuilder(
              stream: state.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData) {
                  return Container(child: Text("Hozirda malumotlar mavjud emas"),);
                }

                final data = snapshot.data?.snapshot.value;
                Map<String, dynamic> chats = {};
                if (data is Map) {
                  chats = data.cast<String, dynamic>();
                }
                List<String> keys = chats.keys.toList();
                ChatModel? chat;
                for (int i = 0; i < keys.length; i++) {
                  print(chats[keys[i]]['user1']['contactId']);
                  print(widget.myModel.contactId);
                  print(_chatUser!.contactId);
                  print(chats[keys[i]]['user2']['contactId']);
                  if (widget.myModel.contactId == chats[keys[i]]['user1']['contactId'].toString() && _chatUser!.contactId == chats[keys[i]]['user2']['contactId'].toString() || _chatUser!.contactId == chats[keys[i]]['user1']['contactId'].toString() && widget.myModel.contactId == chats[keys[i]]['user2']['contactId'].toString()) {
                    List<MessageModel> messages = [];
                    if (chats[keys[i]]['messages'] != null) {
                      List<dynamic> _messageKeys =
                          chats[keys[i]]['messages'].keys.toList();
                      for (int j = 0; j < _messageKeys.length; j++) {
                        final messageData =
                            chats[keys[i]]['messages'][_messageKeys[j]];
                        messages.add(MessageModel(
                          messageId: messageData['messageId'],
                          messageText: messageData['messageText'],
                          isFile: messageData['isFile'] ?? false,
                          createdTime:
                              DateTime.parse(messageData['createdTime']),
                          contactId: messageData['contactId'],
                          status: messageData['status'] ?? false,
                        ));
                      }
                    }
                    chat = ChatModel(
                      user1: ContactModel(
                        contactId: chats[keys[i]]['user1']['contactId'],
                        contactLastName: chats[keys[i]]['user1']
                            ['contactLastName'],
                        contactName: chats[keys[i]]['user1']['contactName'],
                        isOnline: chats[keys[i]]['user1']['isOnline'],
                        imageUrl: chats[keys[i]]['user1']['imageUrl'],
                        lastOnlineTime: DateTime.parse(
                            chats[keys[i]]['user1']['lastOnlineTime']),
                      ),
                      user2: ContactModel(
                        contactId: chats[keys[i]]['user2']['contactId'],
                        contactLastName: chats[keys[i]]['user2']
                            ['contactLastName'],
                        contactName: chats[keys[i]]['user2']['contactName'],
                        isOnline: chats[keys[i]]['user2']['isOnline'],
                        imageUrl: chats[keys[i]]['user2']['imageUrl'],
                        lastOnlineTime: DateTime.parse(
                            chats[keys[i]]['user2']['lastOnlineTime']),
                      ),
                      messages: messages,
                      chatUrl: chats[keys[i]]['chatUrl'],
                    );
                  }
                }
                chat!.messages.reversed;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: chat?.messages.length ?? 0,
                        itemBuilder: (context, index) {
                          final message = chat!.messages[index];
                          return Row(
                            mainAxisAlignment: message.contactId == widget.myModel.contactId
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 260,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                  color: message.contactId == widget.myModel.contactId
                                      ? Colors.green
                                      : Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text("${message.messageText}",style: TextStyle(color: Colors.white,fontSize: 18)),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: TextField(
                        onChanged: (value) {
                          if (value.trim().isEmpty) {
                            setState(() {
                              isSend = false;
                            });
                          } else {
                            setState(() {
                              isSend = true;
                            });
                          }
                        },
                        controller: textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: "Enter message",
                          suffixIcon: !isSend
                              ? const Icon(
                                  Icons.send,
                                  color: Colors.grey,
                                )
                              : InkWell(
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    if (chat != null) {
                                      context.read<ContactChatBloc>().add(
                                          WriteContactChatEvent(
                                              chatUrl: chat!.chatUrl,
                                              messageModel: MessageModel(
                                                  messageId: '',
                                                  messageText:
                                                      textController.text,
                                                  isFile: false,
                                                  createdTime: DateTime.now(),
                                                  contactId:
                                                      widget.myModel.contactId,
                                                  status: false)));
                                      textController.clear();
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
