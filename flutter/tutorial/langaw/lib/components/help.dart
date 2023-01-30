
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';
import 'package:langaw/view.dart';

//  도움말 컴포넌트
class Help extends PositionComponent with HasGameRef<LangawGame>, Tappable {
  late SpriteComponent helpButton;
  late SpriteComponent helpView;

  //  비동기 처리 코드
  @override
  Future<void> onLoad() async {
    helpButton = SpriteComponent(
      sprite: await Sprite.load('ui/icon-help.png'),
      size: Vector2(tileSize, tileSize)
    );
    helpView = SpriteComponent(
        sprite: await Sprite.load('ui/dialog-help.png'),
        size: Vector2(tileSize * 8, tileSize * 12),
        position: Vector2(tileSize * .5, (gameRef.size.y / 2) - (tileSize * 6))
    );

    _addHelpButton();

    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print(gameRef.isHandled);
    if (!gameRef.isHandled) {
      //  컴포넌트가 클릭 되면 처리 중으로 표시하여 다른 행동 못하도록 한다.
      gameRef.isHandled = true;
      gameRef.activeView = View.help;      
      remove(helpButton);
      _addHelpView();
    } else if(gameRef.activeView == View.help) {
      gameRef.activeView = View.home;
      gameRef.isHandled = false;
      remove(helpView);
      _addHelpButton();
    }
    gameRef.handleHelp();
    return super.onTapDown(info);
  }

  void _addHelpButton() {
    size = Vector2(tileSize, tileSize);
    position = Vector2(tileSize * .25, gameRef.size.y - (tileSize * 1.25));
    add(helpButton);
  }

  void _addHelpView() {
    size = gameRef.size;
    position = Vector2(0, 0);
    add(helpView);
  }

}