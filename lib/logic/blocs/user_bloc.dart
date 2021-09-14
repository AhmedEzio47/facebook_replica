import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/user_model.dart';
import 'package:facebook_replica/data/repos/user_repo.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.type) {
      case UserEventType.request:
        UserModel? user = await UserRepo().getUser(event.data);

        if (user != null)
          this.add(UserEvent(type: UserEventType.ready, data: user));
        else
          this.add(UserEvent(type: UserEventType.error));

        break;
      case UserEventType.ready:
        if (event.data is List) {
          for (var user in (event.data as List)) {
            yield UserState(
              user: user,
            );
          }
        } else {
          yield UserState(user: event.data);
        }
        break;
      case UserEventType.error:
        yield UserState();
        break;
      case UserEventType.requestUsers:
        List<UserModel>? users = await UserRepo().getUsers();
        if (users != null)
          this.add(UserEvent(type: UserEventType.ready, data: users));
        else
          this.add(UserEvent(type: UserEventType.error));
        break;
    }
  }
}
