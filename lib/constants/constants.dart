///assets
const String kFacebook_logo = 'assets/images/facebook-logo.png';
const String kImage1 = 'assets/images/posts/post-1.jpg';
const List<String> kUsersAvatars = [
  'assets/images/users/user-1.jpeg',
  'assets/images/users/user-2.jpeg',
  'assets/images/users/user-3.jpeg',
  'assets/images/users/user-4.jpg',
  'assets/images/users/user-5.jpeg',
];

///enums
enum PostEventType { like, loading, ready, request, error }
enum UserEventType { loading, ready, request, error }

///sizes
const double kAvatarRadius = 25;
