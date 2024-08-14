import 'package:dars_73/bloc/auth/auth_bloc.dart';
import 'package:dars_73/bloc/chats/chat_bloc.dart';
import 'package:dars_73/bloc/contact_chat/contact_chat_bloc.dart';
import 'package:dars_73/bloc/contacts_bloc/contact_bloc.dart';
import 'package:dars_73/data/models/contact_model.dart';
import 'package:dars_73/data/repositories/auth_repositories.dart';
import 'package:dars_73/data/repositories/chat_repositories.dart';
import 'package:dars_73/data/repositories/contact_chat_repositories.dart';
import 'package:dars_73/data/repositories/contacts_repositories.dart';
import 'package:dars_73/firebase_options.dart';
import 'package:dars_73/services/auth_services.dart';
import 'package:dars_73/services/chat_services.dart';
import 'package:dars_73/services/contact_chat_services.dart';
import 'package:dars_73/services/contacts_services.dart';
import 'package:dars_73/ui/screens/authentication/login_screen.dart';
import 'package:dars_73/ui/screens/authentication/registration_screen.dart';
import 'package:dars_73/ui/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "name-here",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final pref = await SharedPreferences.getInstance();
  bool user = pref.get("user") == 'true' ? true : false;
  ContactModel? model;
  if (user) {
    model = await AuthServices.getMyContactModelService();
  }
  print(user);
  runApp(MainApp(
    userIsFind: user,
    model: model,
  ));
}

class RestartApp extends StatefulWidget {
  const RestartApp({super.key});

  @override
  State<RestartApp> createState() => _RestartAppState();
}

class _RestartAppState extends State<RestartApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        final pref = await SharedPreferences.getInstance();
        bool user = pref.get("user") == 'true' ? true : false;
        ContactModel? model;
        if (user) {
          model = await AuthServices.getMyContactModelService();
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainApp(userIsFind: user,model: model,)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Chats",style: TextStyle(fontSize: 25,color: Colors.blue),),),
    );
  }
}

class MainApp extends StatelessWidget {
  bool userIsFind;
  ContactModel? model;
  MainApp({super.key, required this.userIsFind, this.model});

  final _services = AuthServices();
  final _contactServices = ContactsServices();
  final _chatServices = ChatServices();
  final _contactChatServices = ContactChatServices();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositories(
            servic: _services,
          ),
        ),
        RepositoryProvider(
            create: (context) =>
                ContactsRepositories(services: _contactServices)),
        RepositoryProvider(
            create: (context) => ChatRepositories(servic: _chatServices)),
        RepositoryProvider(create: (context) => ContactChatRepositories(services: _contactChatServices))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(repo: context.read())),
          BlocProvider(
              create: (context) =>
                  ContactBloc(repo: context.read<ContactsRepositories>(),services: _chatServices),),
          BlocProvider(
              create: (context) =>
                  ChatBloc(repo: context.read<ChatRepositories>())),
          BlocProvider(create: (context) => ContactChatBloc(repo: context.read<ContactChatRepositories>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: userIsFind
              ? HomeScreen(
                  myContactDatas: model!,
                )
              : LoginScreen(),
        ),
      ),
    );
  }
}
