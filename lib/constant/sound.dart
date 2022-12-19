// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:soundpool/soundpool.dart';

final se = SeSound();

enum SeSoundIds {
  bird1,
  phone1,
}

class SeSound {
  SeSound() {
    _soundPool = Soundpool.fromOptions(
      options: const SoundpoolOptions(
        maxStreams: 5,
      ),
    );
    // 以降、非同期で実施
    () async {
      // 読み込んだ効果音をバッファに保持
      final bird1Id = await rootBundle
          .load('assets/se/bird1.mp3')
          .then((value) => _soundPool.load(value));
      final phone1Id = await rootBundle
          .load('assets/se/phone1.mp3')
          .then((value) => _soundPool.load(value));
      // バッファに保持した効果音のIDを以下のコンテナに入れておく
      _seContainer[SeSoundIds.bird1] = bird1Id;
      _seContainer[SeSoundIds.phone1] = phone1Id;
      // 効果音を鳴らしたときに保持するためのstreamIdのコンテナを初期化
      // 対象の効果音を強制的に停止する際に使用する
      _streamContainer[bird1Id] = 0;
      _streamContainer[phone1Id] = 0;
    }();
  }
  String os = Platform.operatingSystem;
  bool isIOS = Platform.isIOS;
  late Soundpool _soundPool;

  final Map<SeSoundIds, int> _seContainer = <SeSoundIds, int>{};
  final Map<int, int> _streamContainer = <int, int>{};

  // 効果音を鳴らすときに本メソッドをEnum属性のSeSoundIdsを引数として実行する
  Future<void> playSe(SeSoundIds ids) async {
    // 効果音のIDを取得
    final seId = _seContainer[ids];
    if (seId != null) {
      final streamId = _streamContainer[seId] ?? 0;
      if (streamId > 0 && isIOS) {
        // streamIdが存在し、かつOSがiOSだった場合、再生中の効果音を強制的に停止させる
        // iOSの場合、再生中は再度の効果音再生に対応していないため、ボタン連打しても再生されないため
        await _soundPool.stop(streamId);
      }
      _streamContainer[seId] = await _soundPool.play(seId);
    } else {
      debugPrint('se resource not found! ids: $ids');
    }
  }

  Future<int> dispose() async {
    // 終了時の後始末処理
    await _soundPool.release();
    _soundPool.dispose();
    return Future.value(0);
  }
}
