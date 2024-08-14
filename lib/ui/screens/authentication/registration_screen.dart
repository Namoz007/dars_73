import 'package:dars_73/bloc/auth/auth_bloc.dart';
import 'package:dars_73/bloc/auth/auth_event.dart';
import 'package:dars_73/bloc/auth/auth_stata.dart';
import 'package:dars_73/ui/screens/authentication/login_textfields.dart';
import 'package:dars_73/ui/screens/authentication/registration_password.dart';
import 'package:dars_73/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _contactLastName = TextEditingController();
  final _contactImgUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is ErrorAuthState) {
                      print("bu state ${state.message}");
                      if (state.message == '') {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(myContactDatas: state.model!),
                            ),
                          );
                        });
                      }
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  "Ro'yxatdan o'tish",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: LoginTextfield(controller: _loginController),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RegistrationPasswords(
                    lastName: _contactLastName,
                    imgUrl: _contactImgUrl,
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        RegistrationLoginAndPasswordAuthEvent(
                          contactName: _loginController.text,
                          contactLastName: _contactLastName.text,
                          imgUrl: _contactImgUrl.text,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is LoadingAuthState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        }
                        return const Text(
                          "Ro'yxatdan o'tish",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Tizimga kirish",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
