import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchedListScreen extends StatefulWidget {
  @override
  _WatchedListScreenState createState() => _WatchedListScreenState();
}

class _WatchedListScreenState extends State<WatchedListScreen> {
  List<String> _watchedList = [];

  @override
  void initState() {
    super.initState();
    _loadWatchedList();
  }

  Future<void> _loadWatchedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchedList = prefs.getStringList('watchedList') ?? [];
    setState(() {
      _watchedList = watchedList;
    });
  }

  Future<void> _removeFromWatchedList(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchedList = prefs.getStringList('watchedList') ?? [];
    watchedList.remove(image);
    await prefs.setStringList('watchedList', watchedList);
    setState(() {
      _watchedList = watchedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _watchedList.isEmpty
          ? const Center(
              child: Text('Watched Movies Watched Yet.'),
            )
          : ListView.builder(
              itemCount: _watchedList.length,
              itemBuilder: (context, index) {
                String watchedImage = _watchedList[index];

                return Dismissible(
                  key: Key(watchedImage),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    _removeFromWatchedList(watchedImage);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image removed from watched list.'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                          height: 400,
                          width: 100,
                          child: Image.asset(
                            watchedImage,
                            fit: BoxFit.fill,
                          )),
                      title: Text('Watched Movies $index'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
