import 'package:facebook_replica/constants/constants.dart';

class PostEvent {
  PostEventType type;
  dynamic data;
  PostEvent({required this.type, this.data});
}
