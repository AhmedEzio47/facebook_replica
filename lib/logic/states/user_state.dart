import 'package:facebook_replica/data/models/user_model.dart';

class UserState {
  UserModel? user;
  UserState({this.user});

  @override
  bool operator ==(other) {
    return (this.user?.id == (other as UserState).user?.id);
  }
}
