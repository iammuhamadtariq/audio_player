import 'package:application_audio_player/audio_file.dart';
import 'package:file_picker/file_picker.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AudioPlayerHomePage());
}

class AudioPlayerHomePage extends StatefulWidget {
  const AudioPlayerHomePage({Key? key}) : super(key: key);

  @override
  _AudioPlayerHomePageState createState() => _AudioPlayerHomePageState();
}

class _AudioPlayerHomePageState extends State<AudioPlayerHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AudioPlayerPage(),
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer advancedPlayer;
  FilePickerResult? result = FilePicker.platform.pickFiles();

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight / 2,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * .6,
              width: screenWidth,
              color: Colors.amberAccent,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 4,
            child: Container(
              width: screenWidth,
              color: Colors.purpleAccent,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * .2,
              height: screenHeight * 0.35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    const Text(
                      "Song Title",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                      ),
                    ),
                    const Text(
                      "Detail of Song",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Avenir",
                      ),
                    ),
                    AudioFile(advancedPlayer: advancedPlayer),
                  ],
                ),
              )),
          Positioned(
            top: screenHeight * .12,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            child: Container(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white70,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'http://www.appsformypc.com/wp-content/uploads/2015/11/502e4a16.png',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
