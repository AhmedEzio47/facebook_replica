import 'package:facebook_replica/constants/dummy_data.dart';

class UserAPI {
  Future getUser(int id) async {
    var rawUser = USERS.firstWhere((element) => element['id'] == id);
    return rawUser;
  }

  Future<List<Map>> getUsers() async {
    await Future.delayed(Duration(seconds: 2));
    return USERS;
  }
}
