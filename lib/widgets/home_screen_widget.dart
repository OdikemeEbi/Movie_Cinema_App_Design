import 'package:cinema_app/widgets/watcheScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _imageList = [
    'assets/images/image4.jpg',
    'assets/images/image8.jpg',
    'assets/images/image.png',
    'assets/images/image1.jpg',
    'assets/images/image4.jpg',
    'assets/images/image8.jpg',
    'assets/images/image4.jpg',
    'assets/images/image8.jpg',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
    'assets/images/image8.jpg',
    'assets/images/image6.jpg',
    'assets/images/image7.jpg',
    'assets/images/image8.jpg',
    'assets/images/image8.jpg',
    'assets/images/image8.jpg',
    'assets/images/image9.jpg',
    'assets/images/image1.jpg',
    'assets/images/image11.jpg',
    'assets/images/image3.png',
  ];

  Future<void> _addToWatchedList(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchedList = prefs.getStringList('watchedList') ?? [];
    watchedList.add(image);
    await prefs.setStringList('watchedList', watchedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 560,
              child: ListView.builder(
                itemCount: _imageList.length,
                itemBuilder: (context, index) {
                  String imagePath = _imageList[index];

                  return GestureDetector(
                    onTap: () {
                      _addToWatchedList(imagePath);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black54,
                                ),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Image(
                                  image:
                                      AssetImage('assets/images/image3.png')),
                            ),
                            title: Text(
                              'Beautiful Aesthetic Flutter App',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'By John Doe',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WatchedListScreen()),
          );
        },
        label: Text('Watched List'),
        icon: Icon(Icons.list),
      ),
    );
  }
}
