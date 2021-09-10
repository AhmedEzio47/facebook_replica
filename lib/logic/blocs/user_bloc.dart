import 'package:facebook_replica/constants/constants.dart';
import 'package:facebook_replica/data/models/user_model.dart';
import 'package:facebook_replica/data/repos/user_repo.dart';
import 'package:facebook_replica/logic/events/user_event.dart';
import 'package:facebook_replica/logic/states/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {}

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    switch (event.type) {
      case UserEventType.request:
        this.add(UserEvent(type: UserEventType.loading));
        List<UserModel>? user = await UserRepo().getUser(event.data);

        if (user != null)
          this.add(UserEvent(type: UserEventType.ready, data: user));
        else
          this.add(UserEvent(type: UserEventType.error));

        break;
      case UserEventType.loading:
        yield UserState(isLoading: true);
        break;
      case UserEventType.ready:
        yield UserState(isLoading: false, userModel: event.data);
        break;
      case UserEventType.error:
        yield UserState();
        break;
    }
  }
}
