import 'package:dars_73/bloc/auth/auth_bloc.dart';
import 'package:dars_73/bloc/auth/auth_event.dart';
import 'package:dars_73/ui/screens/authentication/login_textfields.dart';
import 'package:dars_73/ui/screens/authentication/registration_screen.dart';
import 'package:dars_73/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth/auth_stata.dart';
import 'reset_password_for_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is ErrorAuthState) {
                    print("bu states ${state.message}");
                    if (state.message == '') {
                      Future.delayed(Duration(milliseconds: 100), () {
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
                        "${state.message}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Tizimga kirish",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: LoginTextfield(
                  controller: _loginController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: const Text(
                      "Parolni tiklash",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ResetPasswordForDialog(),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                      InputedLoginAndPasswordAuthEvent(
                        contactName: _loginController.text,
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is LoadingAuthState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    }

                    if (state is InputLoginAndPasswordAuthState ||
                        state is LoadedAuthState) {
                      return InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(
                            InputedLoginAndPasswordAuthEvent(
                              contactName: _loginController.text,
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Kirish",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Ro'yxatdan o'tish",
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
    );
  }
}
