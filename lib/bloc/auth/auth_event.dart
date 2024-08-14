sealed class AuthEvent {}

final class InputedLoginAndPasswordAuthEvent extends AuthEvent {
  String contactName;

  InputedLoginAndPasswordAuthEvent({required this.contactName});
}

final class RegistrationLoginAndPasswordAuthEvent extends AuthEvent {
  String contactName;
  String contactLastName;
  String imgUrl;

  RegistrationLoginAndPasswordAuthEvent({
    required this.contactName,
    required this.contactLastName,
    required this.imgUrl,
  });
}

final class ResetPasswordAuthEvent extends AuthEvent {
  String email;

  ResetPasswordAuthEvent(this.email);
}
