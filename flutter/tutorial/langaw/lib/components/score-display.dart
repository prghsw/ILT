

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:langaw/langaw-game.dart';

class ScoreDisply extends TextComponent with HasGameRef<LangawGame> {
  late TextPaint textPaint;
  late TextStyle textStyle;

  // ScoreDisply(int priority) : super(priority: priority);

  @override
  Future<void> onLoad() async {
    textStyle = TextStyle(
      color : Color(0xffffffff),
      fontSize: 90,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        )
      ],
    );
    textPaint = TextPaint(
      style: textStyle,
      textDirection: TextDirection.ltr,
    );

    textRenderer = textPaint;

    anchor = Anchor.topCenter;
    position = Vector2.all(0);
  }

  @override
  void update(double dt) {
    if ((text) != gameRef.score.toString()) {
      text = gameRef.score.toString();
      position = Vector2((gameRef.size.x / 2) , (gameRef.size.y * .25));
    } else {
      // print('text > $text');
      // print('socre > ${gameRef.score.toString()}');
      // text = gameRef.score.toString();
    }
    super.update(dt);
  }

}