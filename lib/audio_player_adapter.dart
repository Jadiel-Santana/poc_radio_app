import 'package:audioplayers/audioplayers.dart';

import 'music_player.dart';

class AudioPlayerPlayer implements MusicPlayer {
  final _player = AudioPlayer();

  @override
  Future<void> init() async {
    // AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    //   return true;
    // });
  }

  @override
  Future<void> load({required String url}) async {
    await _player.play(UrlSource(url));
  }

  @override
  void pause() => _player.pause();

  @override
  void play() => _player.resume();

  @override
  Stream<Duration> get position => _player.onPositionChanged;

  @override
  Stream<Duration> get totalDuration => _player.onDurationChanged.map(
        (playing) => playing,
      );

  @override
  void seek(Duration position) => _player.seek(position);

  @override
  Future<void> dispose() => _player.release();
}
