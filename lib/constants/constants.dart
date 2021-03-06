import 'package:facebook_replica/logic/blocs/user_bloc.dart';

///assets
const String kFacebookLogo = 'assets/images/facebook-logo.png';
const String kWebLogo = 'assets/images/web-logo.png';
const String kImage1 = 'assets/images/posts/post-1.jpg';
const String kImage2 = 'assets/images/posts/post-2.png';
const String kImage3 = 'assets/images/posts/post-3.jpg';
const String kImage4 = 'assets/images/posts/post-4.jpg';
const String kImage5 = 'assets/images/posts/post-5.jpeg';
const String kDefaultUserAvatar = 'assets/images/users/default-user.jpg';

const List<String> kUsersAvatars = [
  'assets/images/users/user-1.jpeg',
  'assets/images/users/user-2.jpeg',
  'assets/images/users/user-3.jpeg',
  'assets/images/users/user-4.jpg',
  'assets/images/users/user-5.jpeg',
];

///enums
enum PostEventType { like, comment, ready, request, add, error }
enum UserEventType { ready, request, requestUsers, error }

///sizes
const double kAvatarRadius = 22;
const double kPostLoadingHeight = 200;
const double kWebPostListWidth = 900;
const double kLeftPanelItemHeight = 50;
const double kLeftPanelIconSize = 30;
const double kAppbarHeight = 60;
const double kDrawerWidth = 300;
const double kReactionIconSize = 20;
const double kCommentsHeight = 400;

///constants
const int kMaxCharsInPostText = 100;
const kCurrentUserId = 5;
UserBloc kCurrentUserBloc = UserBloc();
