import 'package:facebook_replica/data/models/user_model.dart';

class UserState {
  bool isLoading;
  UserModel? user;
  UserState({this.isLoading = false, this.user});

  @override
  bool operator ==(other) {
    return (this.user?.id == (other as UserState).user?.id);
  }
}
