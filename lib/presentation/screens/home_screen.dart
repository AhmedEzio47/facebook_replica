import 'package:facebook_replica/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Logo(
        width: MediaQuery.of(context).size.width,
        height: 60,
      ),
      body: Center(child: Text('Posts')),
    );
  }
}
