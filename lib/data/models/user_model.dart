class UserModel {
  int id;
  String name;
  String avatar;

  UserModel({required this.id, required this.name, required this.avatar});

  factory UserModel.fromRawUser(rawUser) {
    return UserModel(
        id: rawUser['id'], name: rawUser['name'], avatar: rawUser['avatar']);
  }
}
