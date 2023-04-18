import 'package:assets_audio_player/assets_audio_player.dart';

import 'music_player.dart';

class AssetsAudioPlayerPlayer implements MusicPlayer {
  final _player = AssetsAudioPlayer();

  @override
  Future<void> init() async {
    AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
      return true;
    });
  }

  @override
  Future<void> load(String url) async {
    await _player.open(
      Audio.network(
        url,
        metas: Metas(
          title: "Radio App",
          artist: "Florent Champigny",
          album: "CountryAlbum",
          image: const MetasImage.network("https://files.tecnoblog.net/wp-content/uploads/2020/03/google-imagens-700x394.jpg"),
        ),
      ),
      showNotification: true,
    );
  }

  @override
  void pause() => _player.pause();

  @override
  void play() => _player.play();

  @override
  Stream<Duration> get position => _player.currentPosition;

  @override
  Stream<Duration> get totalDuration => _player.current.map(
        (playing) => playing?.audio.duration ?? Duration.zero,
      );

  @override
  void seek(Duration position) => _player.seek(position);

  @override
  Future<void> dispose() => _player.dispose();
}
