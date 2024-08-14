import 'package:dars_73/data/models/contact_model.dart';

sealed class AuthState {}

final class InputLoginAndPasswordAuthState extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class LoadedAuthState extends AuthState {}

final class ErrorAuthState extends AuthState {
  String message;
  ContactModel? model;

  ErrorAuthState({required this.message,this.model});
}
