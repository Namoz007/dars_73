import 'package:dars_73/bloc/auth/auth_bloc.dart';
import 'package:dars_73/bloc/auth/auth_event.dart';
import 'package:dars_73/bloc/auth/auth_stata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForDialog extends StatefulWidget {
  const ResetPasswordForDialog({super.key});

  @override
  State<ResetPasswordForDialog> createState() => _ResetPasswordForDialogState();
}

class _ResetPasswordForDialogState extends State<ResetPasswordForDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Parolni tiklash"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email bo'sh bo'lmasligi kerak";
                }

                if (!value.contains("@")) {
                  return "Emailda @ belgisi bo'lishi kerak";
                }

                return null;
              },
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  hintText: "Email"),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              context
                  .read<AuthBloc>()
                  .add(ResetPasswordAuthEvent(_emailController.text));
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is LoadingAuthState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              }
              return Text("Yuborish");
            },
          ),
        ),
      ],
    );
  }
}
