import 'package:cinema_app/screens/profile.dart';
import 'package:cinema_app/widgets/add_movies.dart';
import 'package:cinema_app/widgets/watcheScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/home_screen_widget.dart';

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Cinema App',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          indicatorColor: Colors.black38,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(text: 'Watched List'),
            Tab(text: 'Add Movies'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.purple,
                ),
              ),
            ),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[HomeScreen(), WatchedListScreen(), AddMovies()],
      ),
    );
  }
}
