import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langaw/langaw-game.dart';

void main() async {
  //  main에서 비동기 처리시 바인딩 완료 후 처리 되도록 설정.
  WidgetsFlutterBinding.ensureInitialized();

  //  전체화면
  await Flame.device.fullScreen();
  //  세로
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);

  //  Flame의 이미지 미리 가져오기 (global image cache)
  await Flame.images.loadAll(<String>[
    'bg/backyard.png',
    'bg/lose-splash.png',
    'ui/dialog-credits.png',
    'ui/dialog-help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/start-button.png',
    'ui/callout.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
  ]);

  LangawGame game = LangawGame();
  runApp(GameWidget(game: game));
}