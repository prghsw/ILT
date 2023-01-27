
import 'package:flame/components.dart';

//  mixin HasGameRef 확장 기능
extension GameExtension on HasGameRef {
  //  컴포넌트의 화면별 적정 사이즈 (9:x)
  double get tileSize {
    return game.size.x / 9;
  }
}