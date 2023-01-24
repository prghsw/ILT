import 'components/fly.dart';
import 'dart:ui';
import 'package:flame/game.dart';

class LangawGame extends FlameGame {
  final List<Fly> _flies = [];

  //  비동기 초기화 코드 사용
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // add(_fly);
  }

  //  백그라운드 변경
  @override
  Color backgroundColor() => const Color(0xff576574);

}