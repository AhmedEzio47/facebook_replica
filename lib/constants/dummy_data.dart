import 'package:facebook_replica/constants/constants.dart';

///Posts
List<Map> POSTS = [
  {
    'id': 1,
    'text':
        'Welcome to Facebook replica mad using BLoC, an amazing design pattern and state providing tool.',
    'images': [kImage1],
    'timestamp': 0,
    'likes': 6,
    'comments': 5,
    'is_liked': false,
    'user_id': 1
  },
  {
    'id': 2,
    'text':
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
           when an unknown printer took a galley of type and scrambled it to make a type specimen book.
           It has survived not only five centuries, but also the leap into electronic typesetting, 
           remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets, 
           containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
    'images': [],
    'likes': 5,
    'comments': 5,
    'is_liked': true,
    'timestamp': 1631331046,
    'user_id': 2
  },
  {
    'id': 3,
    'text': 'Flutter is just awesome',
    'images': [kImage2],
    'timestamp': 1631330046,
    'likes': 10,
    'comments': 5,
    'is_liked': false,
    'user_id': 3
  },
  {
    'id': 4,
    'text': 'I love animals.',
    'images': [kImage3, kImage4, kImage5],
    'timestamp': 1631251046,
    'likes': 23,
    'comments': 5,
    'is_liked': true,
    'user_id': 4
  },
  {
    'id': 5,
    'text':
        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
           when an unknown printer took a galley of type and scrambled it to make a type specimen book.
           It has survived not only five centuries, but also the leap into electronic typesetting.''',
    'images': [],
    'likes': 67,
    'comments': 5,
    'is_liked': false,
    'timestamp': 1631231046,
    'user_id': 5
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

const List<Map> MENU = [
  {'icon': 'assets/icons/friends.png', 'label': 'Friends'},
  {'icon': 'assets/icons/jobs.png', 'label': 'Jobs'},
  {'icon': 'assets/icons/groups.png', 'label': 'Groups'},
  {'icon': 'assets/icons/marketplace.png', 'label': 'Marketplace'},
  {'icon': 'assets/icons/watch.png', 'label': 'Watch'},
  {'icon': 'assets/icons/ad-center.png', 'label': 'Ad Center'},
  {'icon': 'assets/icons/ads-manager.png', 'label': 'Ads Manager'},
  {'icon': 'assets/icons/blood-donations.png', 'label': 'Blood Donations'},
  {'icon': 'assets/icons/business-manager.png', 'label': 'Business Manager'},
  {'icon': 'assets/icons/campus.png', 'label': 'Campus'},
  {'icon': 'assets/icons/community-help.png', 'label': 'Community Help'},
  {
    'icon': 'assets/icons/covid-info-center.png',
    'label': 'COVID-19 Information Center'
  },
  {'icon': 'assets/icons/emotional-health.png', 'label': 'Emotional Health'},
  {'icon': 'assets/icons/events.png', 'label': 'Events'},
  {'icon': 'assets/icons/facebook-pay.png', 'label': 'Facebook Pay'},
  {'icon': 'assets/icons/favorites.png', 'label': 'Favorites'},
  {'icon': 'assets/icons/fundraisers.png', 'label': 'Fundraisers'},
  {'icon': 'assets/icons/gaming-video.png', 'label': 'Gaming Video'},
  {'icon': 'assets/icons/live-videos.png', 'label': 'Live Videos'},
  {'icon': 'assets/icons/memories.png', 'label': 'Memories'},
  {'icon': 'assets/icons/messenger.png', 'label': 'Messenger'},
  {'icon': 'assets/icons/messenger-kids.png', 'label': 'Messenger Kids'},
  {'icon': 'assets/icons/most-recent.png', 'label': 'Most Recent'},
  {'icon': 'assets/icons/pages.png', 'label': 'Pages'},
  {'icon': 'assets/icons/play-games.png', 'label': 'Play Games'},
  {
    'icon': 'assets/icons/recent-ad-activity.png',
    'label': 'Recent Ad Activity'
  },
  {'icon': 'assets/icons/saved.png', 'label': 'Saved'},
  {'icon': 'assets/icons/weather.png', 'label': 'Weather'},
];
