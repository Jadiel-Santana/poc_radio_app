import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'audio_player_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC Radio App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _player = AudioPlayerPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    _player.init();
    _loadSong();
    super.initState();
  }

  Future<void> _loadSong() async {
    await _player.load(url: 'https://play.radio.br:8089/mncaxias/mncaxias/playlist.m3u8');

    setState(() => isPlaying = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Duration>(
                stream: _player.totalDuration,
                builder: (context, totalDurationSnapshot) {
                  return StreamBuilder<Duration>(
                    stream: _player.position,
                    builder: (context, positionSnapshot) {
                      return ProgressBar(
                        progress: positionSnapshot.data ?? Duration.zero,
                        total: totalDurationSnapshot.data ?? Duration.zero,
                        onSeek: _player.seek,
                      );
                    },
                  );
                },
              ),
              FloatingActionButton(
                onPressed: () {
                  (isPlaying) ? _player.pause() : _player.play();

                  setState(() => isPlaying = !isPlaying);
                },
                tooltip: 'Play e pause',
                child: Icon((isPlaying) ? Icons.pause_rounded : Icons.play_arrow_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}