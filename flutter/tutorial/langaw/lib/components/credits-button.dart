
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flame/input.dart';

class CreditsButton extends SpriteComponent with HasGameRef<LangawGame>, Tappable {

  //  비동기 초기 코드
  Future<void> onLoad() async {
    sprite = await Sprite.load('ui/icon-credits.png');
  }

}