import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

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
  RadioPlayer radioPlayer = RadioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    radioPlayer.setChannel(title: 'Jadiel', url: 'https://play.radio.br:8089/mncaxias/mncaxias/playlist.m3u8');
    super.initState();
  }

  void _incrementCounter() {
    (isPlaying) ? radioPlayer.pause() : radioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Esse funciona bem para os 2 formatos\nde arquivos e não contém widgets\nobrigatórios, porém não tem o\nprogresso de audio para\nexibir o timer e o life.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Play e pause',
        child: Icon((isPlaying) ? Icons.pause_rounded : Icons.play_arrow_rounded),
      ),
    );
  }
}
