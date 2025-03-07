import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

class AssetPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer(playerId: "You want id? what about 'uwu'?");
  final List<AssetSource> _assets;
  int _currentIndex = 0;
  AssetPlayer(this._assets);

  AssetPlayer.withInitialAsset(this._assets, {required String initialAsset}) {
    for (int i = 0; i < _assets.length; i++) {
      if (_assets[i].path == initialAsset) {
        _currentIndex = i;
        print("AssetPlayer: initialAsset index is $_currentIndex");
        break;
      }
    }
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  String getCurrentMusicName() {
    var asset = _assets[_currentIndex];
    return File(asset.path).uri.pathSegments.last;
  }

  Future<void> play() async {
    if (_assets.isEmpty) {
      return;
    }

    await _audioPlayer.play(_assets[_currentIndex]);
  }

  Future<String?> previous() async {
    if (_assets.isEmpty) {
      return null;
    }

    _currentIndex--;

    if (_currentIndex < 0) {
      _currentIndex = _assets.length - 1;
    }

    await play();

    return getCurrentMusicName();
  }

  Future<String?> next() async {
    if (_assets.isEmpty) {
      return null;
    }

    _currentIndex++;

    if (_currentIndex >= _assets.length) {
      _currentIndex = 0;
    }

    await play();

    return getCurrentMusicName();
  }
}