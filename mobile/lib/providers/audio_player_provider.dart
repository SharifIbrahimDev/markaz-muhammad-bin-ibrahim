import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/audio_lesson.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  AudioLesson? _currentTrack;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _speed = 1.0;

  AudioPlayerProvider() {
    _player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _player.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  AudioLesson? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  double get speed => _speed;
  AudioPlayer get player => _player;

  Future<void> playTrack(AudioLesson track) async {
    _currentTrack = track;
    try {
      await _player.setUrl(track.audioUrl);
      await _player.play();
    } catch (e) {
      debugPrint('Audio Playback note: $e');
    }
    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play();
    }
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> cycleSpeed() async {
    final speeds = [1.0, 1.25, 1.5, 1.75, 2.0, 0.75];
    final nextIndex = (speeds.indexOf(_speed) + 1) % speeds.length;
    _speed = speeds[nextIndex];
    await _player.setSpeed(_speed);
    notifyListeners();
  }

  void stop() {
    _player.stop();
    _currentTrack = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
