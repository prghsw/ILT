
import 'package:flame/components.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';

//  타이틀 View
class HomeView extends SpriteComponent with HasGameRef {

  @override
  Future<void> onLoad() async {
    //  타이틀 이미지 가져오기
    sprite = await game.loadSprite('branding/title.png');
    //  사이즈 설정
    size = Vector2(tileSize * 7, tileSize * 4);
    //  위치 설정
    position = Vector2(tileSize, (game.size.y / 2) - (tileSize * 4));
    return super.onLoad();
  }

}