import 'package:facebook_replica/data/models/user_model.dart';

class UserState {
  bool isLoading;
  UserModel? userModel;
  UserState({this.isLoading = false, this.userModel});
}
