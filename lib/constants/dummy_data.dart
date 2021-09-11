import 'package:facebook_replica/constants/constants.dart';

///Posts
List<Map> POSTS = [
  {
    'id': 1,
    'text':
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
           when an unknown printer took a galley of type and scrambled it to make a type specimen book.
           It has survived not only five centuries, but also the leap into electronic typesetting, 
           remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets, 
           containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
    'images': [],
    'likes': 5,
    'comments': 5,
    'is_liked': true,
    'timestamp': 1631331046,
    'user_id': 1
  },
  {
    'id': 2,
    'text': 'post 2',
    'images': [],
    'timestamp': 0,
    'likes': 5,
    'comments': 5,
    'is_liked': true,
    'user_id': 2
  },
];

List<Map> USERS = [
  {
    'id': 1,
    'name': 'User 1',
    'avatar': kUsersAvatars[0],
  },
  {
    'id': 2,
    'name': 'User 2',
    'avatar': kUsersAvatars[1],
  },
  {
    'id': 3,
    'name': 'User 3',
    'avatar': kUsersAvatars[2],
  },
  {
    'id': 4,
    'name': 'User 4',
    'avatar': kUsersAvatars[3],
  },
  {
    'id': 5,
    'name': 'User 5',
    'avatar': kUsersAvatars[4],
  },
];
