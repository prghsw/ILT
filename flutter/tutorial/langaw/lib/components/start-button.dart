
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';
import 'package:langaw/view.dart';

//  시작 버튼 컴포넌트
class StartButton extends SpriteComponent with HasGameRef<LangawGame>, Tappable {

  //  비동기 초기화 처리
  Future<void> onLoad() async {
    //  시작 버튼 이미지
    sprite = await Sprite.load('ui/start-button.png');
    //  크기 조정
    size = Vector2(tileSize * 6, tileSize * 3);
    //  위치 설정
    position = Vector2(tileSize * 1.5, (gameRef.size.y * .75) - (tileSize * 1.5));
    return super.onLoad();
  }

  // 터치 다운 처리
  @override
  bool onTapDown(TapDownInfo info) {
    gameRef.activeView = View.playing;
    gameRef.homeView.removeFromParent();
    gameRef.flySpawner.start();
    this.removeFromParent();
    return super.onTapDown(info);
  }
}