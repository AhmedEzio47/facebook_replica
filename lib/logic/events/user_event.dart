import 'package:facebook_replica/constants/constants.dart';

class UserEvent {
  UserEventType type;
  dynamic data;
  UserEvent({required this.type, this.data});
}
