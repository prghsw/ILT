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

  LangawGame game = LangawGame();
  runApp(GameWidget(game: game));
}