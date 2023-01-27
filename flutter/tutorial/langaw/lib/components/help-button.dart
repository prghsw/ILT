
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';

//  도움말 컴포넌트
class HelpButton extends SpriteComponent with HasGameRef<LangawGame>, Tappable {

  //  비동기 처리 코드
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ui/icon-help.png');
    size = Vector2(tileSize, tileSize);
    position = Vector2(tileSize * .25, gameRef.size.y - (tileSize * 1.25));
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    
    return super.onTapDown(info);
  }

}