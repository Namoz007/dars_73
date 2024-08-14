import 'package:bloc/bloc.dart';
import 'package:dars_73/bloc/auth/auth_event.dart';
import 'package:dars_73/bloc/auth/auth_stata.dart';
import 'package:dars_73/data/repositories/auth_repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _repositories;

  AuthBloc({required AuthRepositories repo})
      : _repositories = repo,
        super(InputLoginAndPasswordAuthState()) {
    on<InputedLoginAndPasswordAuthEvent>(_login);
    on<RegistrationLoginAndPasswordAuthEvent>(_registration);
  }

  Future<void> _registration(
      RegistrationLoginAndPasswordAuthEvent event, emit) async {
    emit(LoadingAuthState());
    final data = await _repositories.registration(
        event.contactName, event.contactLastName, event.imgUrl,);
    if (data == null)
      emit(ErrorAuthState(message: "user find"),);
    else
      emit(ErrorAuthState(message: '',model: data));
  }

  Future<void> _login(InputedLoginAndPasswordAuthEvent event, emit) async {
    emit(LoadingAuthState());
    final data = await _repositories.login(event.contactName);
    if (data == null)
      emit(ErrorAuthState(message: "not user",));
    else
      emit(ErrorAuthState(message: "",model: data));
  }
}
