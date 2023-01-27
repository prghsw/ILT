
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';

//  게임 종료 이미지
class LostView extends SpriteComponent with HasGameRef<LangawGame> {

  //  비동기 초기화 코드
  @override
  Future<void> onLoad() async {
    //  게임 종료 이미지
    sprite = await Sprite.load('bg/lose-splash.png');
    //  크기 조정
    size = Vector2(tileSize * 7, tileSize * 5);
    //  위치 조정
    position = Vector2(tileSize, (gameRef.size.y / 2) - (tileSize * 5));
    return super.onLoad();
  }
}