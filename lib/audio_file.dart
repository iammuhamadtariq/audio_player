import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  AudioPlayer advancedPlayer;
  AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  String path =
      "https://firebasestorage.googleapis.com/v0/b/video-image-audio.appspot.com/o/audios%2FSHAHID%20AFRIDI%20LONGEST%20SIX%20158%20METER%20OUT%20OF%20GROUND.mp3?alt=media&token=62d71ddd-1a92-42d3-9ff1-833c342f1ba8";
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _isRepeat = false;
  Color _repeadColor = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];

  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer.setUrl(path);
    widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (_isRepeat == true) {
          _repeadColor = Colors.black;
          _isPlaying = true;
        } else {
          _isPlaying = false;
          _isRepeat = false;
        }
      });
    });
  }

  Widget buttonStart() {
    return IconButton(
        onPressed: () {
          if (_isPlaying == false) {
            widget.advancedPlayer.play(path);
            setState(() {
              _isPlaying = true;
            });
          } else if (_isPlaying == true) {
            widget.advancedPlayer.pause();
            setState(() {
              _isPlaying = false;
            });
          }
        },
        icon: _isPlaying == false
            ? Icon(
                _icons[0],
                size: 40,
                color: Colors.blue,
              )
            : Icon(
                _icons[1],
                size: 40,
              ));
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget slowButton() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(0.5);
        },
        icon: Icon(Icons.fast_rewind_rounded));
  }

  Widget fastButton() {
    return IconButton(
        onPressed: () {
          widget.advancedPlayer.setPlaybackRate(1.5);
        },
        icon: Icon(Icons.fast_forward_rounded));
  }

  Widget buttonRepeat() {
    return IconButton(
        onPressed: () {
          if (_isRepeat == false) {
            setState(() {
              widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
              _isRepeat = true;
              _repeadColor = Colors.blue;
            });
          } else if (_isRepeat == true) {
            setState(() {
              widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
              _isRepeat = false;
              _repeadColor = Colors.black;
            });
          }
        },
        icon: Icon(
          Icons.repeat_rounded,
          color: _repeadColor,
        ));
  }

  Widget buttonLoop() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.loop_rounded));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_position.toString().split(".")[0]),
              Text(_duration.toString().split(".")[0]),
            ],
          ),
        ),
        slider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buttonLoop(),
              slowButton(),
              buttonStart(),
              fastButton(),
              buttonRepeat()
            ]),
      ],
    );
  }
}
