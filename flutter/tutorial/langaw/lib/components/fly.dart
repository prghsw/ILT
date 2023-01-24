//  컴포넌트
import 'dart:ui'; //  Canvas를 접근 할 수 있다.
import 'package:flame/components.dart';

class Fly extends PositionComponent with HasGameRef {
  late Rect _flyRect;  //  위치, 크기 설정
  Paint _flyPaint;  //  컴포넌트 색상

  // 생성자
  Fly() : this._flyPaint = Paint()..color = Color(0xff6ab04c);
  

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2.all(gameRef.size.x / 9);
    _flyRect = Rect.fromLTWH(0, 0, size.x, size.y);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(_flyRect, _flyPaint);
    super.render(canvas);
  }
}