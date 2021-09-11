import 'package:facebook_replica/data/models/user_model.dart';
import 'package:facebook_replica/data/providers/user_provider.dart';

class UserRepo {
  final UserAPI _userAPI = UserAPI();
  Future getUser(int id) async {
    try {
      var rawUser = await _userAPI.getUser(id);
      return UserModel.fromRawUser(rawUser);
    } catch (ex) {
      print('user repo: $ex');
      return null;
    }
  }

  Future<List<UserModel>?> getUsers() async {
    try {
      List<Map> rawUsersData = await _userAPI.getUsers();
      return rawUsersData
          .map((rawUser) => UserModel.fromRawUser(rawUser))
          .toList();
    } catch (ex) {
      print('post repo: $ex');
      return null;
    }
  }
}
