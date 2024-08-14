class UserModel {
  String email;
  String fullName;

  UserModel({
    required this.email,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> mp) {
    return UserModel(
      email: mp['email'],
      fullName: mp['fullName'],
    );
  }

  Map<String, dynamic> toMap(UserModel model) {
    return {
      "email": model.email,
      "fullName": model.fullName,
    };
  }
}
