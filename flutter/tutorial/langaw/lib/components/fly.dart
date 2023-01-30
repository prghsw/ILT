//  컴포넌트
import 'dart:ui'; //  Canvas를 접근 할 수 있다.
import 'dart:math'; //  수학 라이브러리
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:langaw/components/flyKind.dart';
import 'package:langaw/extension/hasGameRef-extension.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/view.dart';

class Fly extends SpriteAnimationComponent with HasGameRef<LangawGame>, Tappable {
  // late Rect _flyRect;  //  위치, 크기 설정
  // Paint _flyPaint;  //  컴포넌트 색상
  bool isOffScreen = false;  //  화면 밖으로 벗어난 여부
  bool isDead = false; //  파리 컴포넌트의 죽음 여부
  late double speed; //  파리 이동 속도
  late Vector2 targetLocation;  //  이동할 타겟 위치
  late FlyKind flyKind;  //  파리 별 정보
  late Rect _flyRect;
  late Rect _pintRect;
  late Paint _flyPaint;
  late Paint _pointPaint;

  late final SpriteAnimation _flyingSpriteAnimation;  //  날으는 애니메이션
  late final SpriteAnimation _deadSpriteAnimation;    //  죽는 애니메이션

  // 생성자
  // Fly(this.orgSize)
            // : this._flyPaint = Paint()..color = Color(0xff6ab04c),
            // super(size: Vector2.all(orgSize));

  //  비동기 초기화 처리
  @override
  Future<void> onLoad() async {
    super.onLoad();
    int flyRnd = Random().nextInt(5);
    flyKind = FlyKind.values[flyRnd];
    //  랜덤으로 파리 애니메이션 처리.
    await _setFlyAnimation().then((_) => animation = _flyingSpriteAnimation);
    //  파리 별 크기 재조정
    size = Vector2.all((tileSize * flyKind.size));
    //  파리 속도 조정
    speed = size.x * flyKind.speed;
    //  위치 설정
    double fx = Random().nextDouble() * (gameRef.size.x - size.x); //  처음 위치 x 축
    double fy = Random().nextDouble() * (gameRef.size.y - size.x); //  처음 위치 y 축
    position = Vector2(fx, fy); //  컴포넌트 위치 설정
    _setTargetLocation(); //  컴포넌트 이동 위치 설정
    // _flyPaint = Paint()..color = Color.fromARGB(255, 255, 0, 0);
    // _pointPaint = Paint()..color = Color.fromARGB(255, 21, 255, 0);
    // _flyRect = Rect.fromLTWH((width/2)/2, (height/2)/2, (width/2), (height/2));
    // _pintRect = Rect.fromLTWH((width/2)/2, (height/2)/2, (width/2), (height/2));

  }

  //  렌더링 처리 (화면에 그리는 것을 처리 한다.)
  @override
  void render(Canvas canvas) {
    // canvas.drawRect(_flyRect, _flyPaint);
    // canvas.drawRect(_pintRect, _pointPaint);
    super.render(canvas);
  }

  //  업데이트 처리 (컴포넌트의 변경 사항을 처리 한다.)
  @override
  void update(double dt) {
    if (isDead) {
      animation = _deadSpriteAnimation;
      //  초당 타일의 이동 계산 (gameTile크기 * 12(타일의 이동 폭) * dt(델타시간))
      // _flyRect = _flyRect.translate(0, size.x * 12 * dt); //  Rect의 위치를 변경 한다.
      position.add(Vector2(0, size.x * 12 * dt)); //  실제 컴포넌트의 위치를 변경한다.
      //  파리 컴포넌트가 화면 밖으로 나갔는지 확인한다.
      if (position.y > gameRef.size.y) {
        isOffScreen = true;
        removeFromParent();
      }
    } else {
      //  파리 이동 시키기 (Vector2의 moveToTarget (이동할 위치, 한번 이동할 거리))
      position.moveToTarget(targetLocation, (speed * dt));
      //  이동할 거리 보다 적으면 타겟을 다시 지정하여 다른 곳으로 이동 시킨다.
      if (position.distanceTo(targetLocation) < (speed * dt)) {
        _setTargetLocation();
      }
    }
    super.update(dt);
  }

  //  마우스 클릭 처리
  @override
  bool onTapDown(TapDownInfo info) {
    var realX = info.eventPosition.global.x - x;  //  클릭 x축
    var realY = info.eventPosition.global.y - y;  //  클릭 y축
    var checkX = (width/2)/2;  // hitbox 구성 x
    var checkY = (height/2)/2;  //  hitbox 구성 y
    var checkWidth = (width/2);    //  hitbox 구성 width
    var checkHeight = (height/2);   //  hitbox 구성 height

    var real = Offset(realX, realY);
    _flyRect = Rect.fromLTWH(checkX, checkY, checkWidth, checkHeight);
    // _pintRect = Rect.fromLTWH(realX, realY, 1, 1);
    //  hitbox 클릭시에만 처리 한다.
    if (_flyRect.contains(real)) {
      if (!isDead) {
        isDead = true;
        if (gameRef.activeView == View.playing) {
          gameRef.score += 1;
        }
        FlameAudio.play('sfx/ouch' + (Random().nextInt(11) + 1).toString() + '.ogg');
      }
      // _flyPaint.color = Color(0xffff4757);  //  클릭 시 색상 변경
    }

    // gameRef.flies.remove(this);
    // gameRef.spawnFly();
    return super.onTapDown(info);
  }

  /**
   * 파리 스프라이트 이미지 가져오기
   */
  Future<void> _setFlyAnimation() async {
    //  파리 이미지 가져오기 및 애니메이션화 시키기.
    List<String> alivePath = flyKind.alive;
    String deadPath = flyKind.dead;
    final sprites = alivePath.map((path) => Sprite.load(path));
    _flyingSpriteAnimation = SpriteAnimation.spriteList(
      await Future.wait(sprites), stepTime: 0.1);
    _deadSpriteAnimation = SpriteAnimation.spriteList([await Sprite.load(deadPath)], stepTime: 0.1);
  }

  /**
   * 파리 이동 위치 설정
   */
  void _setTargetLocation() {
    double tx = Random().nextDouble() * (gameRef.size.x - size.x); //  이동 할 위치 x 축
    double ty = Random().nextDouble() * (gameRef.size.y - size.x); //  이동 할 위치 y 축
    targetLocation = Vector2(tx, ty); //  컴포넌트 이동할 위치 설정
  }

}