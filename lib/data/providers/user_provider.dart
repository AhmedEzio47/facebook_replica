import 'package:facebook_replica/constants/dummy_data.dart';

class UserAPI {
  Future getUser(int id) async {
    var rawUser = USERS.firstWhere((element) => element['id'] == id);
    return rawUser;
  }
}
