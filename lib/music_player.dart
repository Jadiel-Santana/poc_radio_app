abstract class MusicPlayer {
  Future<void> init();
  Future<void> load({required String url});
  void play();
  void pause();
  void seek(Duration position);
  Stream<Duration> get position;
  Stream<Duration> get totalDuration;
  Future<void> dispose();
}
