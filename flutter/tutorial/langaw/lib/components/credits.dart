
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:flame/input.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';
import 'package:langaw/view.dart';

class Credits extends PositionComponent with HasGameRef<LangawGame>, Tappable {
  late SpriteComponent creditsButton;
  late SpriteComponent creditsView;

  //  비동기 초기 코드
  Future<void> onLoad() async {
    creditsButton = SpriteComponent(
      sprite: await Sprite.load('ui/icon-credits.png'),
      size: Vector2(tileSize, tileSize)
    );
    creditsView = SpriteComponent(
      sprite: await Sprite.load('ui/dialog-credits.png'),
      size: Vector2(tileSize * 8, tileSize * 12),
      position : Vector2(tileSize * .5, (gameRef.size.y / 2) - (tileSize * 6))
    );

    _addCreditButton();
    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (!gameRef.isHandled) {
      gameRef.activeView = View.credit;
      gameRef.isHandled = true;
      remove(creditsButton);
      _addCreditView();
    } else if(gameRef.activeView == View.credit) {
      gameRef.activeView = View.home;
      gameRef.isHandled = false;
      remove(creditsView);
      _addCreditButton();
    }

    gameRef.handleCredit();
    return super.onTapDown(info);
  }

  void _addCreditButton() {
    size =  Vector2(tileSize, tileSize);
    position = Vector2(gameRef.size.x - (tileSize * 1.25), gameRef.size.y - (tileSize * 1.25));
    add(creditsButton);
  }

  void _addCreditView() {
    size = gameRef.size;
    position = Vector2(0, 0);
    add(creditsView);
  }

}

