import 'dart:io';

import 'package:cinema_app/screens/preferences/shared_preferecces.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddMovies extends StatefulWidget {
  @override
  _AddMoviesState createState() => _AddMoviesState();
}

class _AddMoviesState extends State<AddMovies> {
  List<File> _videos = [];
  List<VideoPlayerController> _videoControllers = [];
  List<VideoPlayerController> _initializedControllers = [];
  List<bool> _isPlaying = [];
  List<Duration> _videoDuration = [];

  Future<void> _pickVideos() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedVideo =
        await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      final File videoFile = File(pickedVideo.path);
      final VideoPlayerController controller =
          VideoPlayerController.file(videoFile);
      await controller.initialize();
      _initializedControllers.add(controller);
      _isPlaying.add(false);
      _videoDuration.add(controller.value.duration);
      setState(() {
        _videos.add(videoFile);
        _videoControllers.add(controller);
      });

      // Save the updated list of videos to SharedPreferences
      final List<String> videoPaths =
          _videos.map((video) => video.path).toList();
      SharedPreferencesManager().addToWatchedList(videoPaths);
    }
  }

  void _playVideo(int index) {
    setState(() {
      _isPlaying[index] = true;
      _videoControllers[index].play();
    });
  }

  void _pauseVideo(int index) {
    setState(() {
      _isPlaying[index] = false;
      _videoControllers[index].pause();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _videoControllers.forEach((controller) {
        controller.addListener(() {
          setState(() {});
        });
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    height: constraints.maxWidth /
                        _videoControllers[index].value.aspectRatio,
                    width: double.maxFinite, // Set the desired height here
                    child: AspectRatio(
                      aspectRatio: _videoControllers[index].value.aspectRatio,
                      child: VideoPlayer(_videoControllers[index]),
                    ),
                  );
                }),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                            size: 30,
                            _isPlaying[index] ? Icons.pause : Icons.play_arrow),
                        onPressed: () {
                          if (_isPlaying[index]) {
                            _pauseVideo(index);
                          } else {
                            _playVideo(index);
                          }
                        },
                      ),
                      Text(
                        _formatDuration(
                            _videoControllers[index].value.position),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        onPressed: _pickVideos,
        label: Text('Add Videos'),
        icon: Icon(Icons.add),
      ),
    ));
  }
}
