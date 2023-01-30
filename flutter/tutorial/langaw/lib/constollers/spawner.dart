


import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:langaw/langaw-game.dart';
import 'package:langaw/view.dart';

import '../components/fly.dart';

//  파리 스폰 컴포넌트
class FlySpawner extends PositionComponent with HasGameRef<LangawGame>, Tappable {
  final int maxSpawnInterval = 3000;  //  최대 스폰 지연 시간
  final int minSpawnInterval = 250;   //  최소 스폰 지연 시간
  final int intervalChange = 3;       //  지연시간 변경
  final int maxFliesOnScreen = 7;     //  최대 파리 수
  late int currentInterval;           //  현재 지연 시간
  late int nextSpawn;                 //  다음 스폰 시간
  bool didHitAtFly = false;           //  파리 터치 여부
  List<Fly> flies = [];               //  생성된 파리 목록

  // FlySpawner(int priotiy) : super(priority: priotiy);

  //  비동기 초기화 코드
  @override
  Future<void> onLoad() async {
    size = gameRef.size;

    //  시작
    start();
    //  최초 파리 스폰
    this.spawnFly();
  }

  @override
  void update(double dt) {
    flies.removeWhere((fly) => fly.isOffScreen);
    //  현재 시간
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    //  살아 있는 파리 수 확인
    int livingFlies = 0;
    flies.forEach((fly) {
      if (!fly.isDead) livingFlies += 1;
    });

    //  현재시간이 다음 스폰 시간 보다 크거나 살아 있는 파리 수가 최대 파리수 보다 작으면 처리.
    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      //  파리 한마리 스폰
      this.spawnFly();
      //  현재 지연시간이 최소 스폰 지연시간 보다 크면 처리
      if (currentInterval > minSpawnInterval) {
        //  현재 지연 시간에서 변경 지연시간을 뺀다.
        currentInterval -= intervalChange;
        //  현재 지연시간에서 (현재 지연시간 * .02)를 뺀다.
        currentInterval -= (currentInterval * .02).toInt();
      }
      // print("currentInterval > $currentInterval");
      //  다음 스폰 시간을 정한다.
      nextSpawn = nowTimestamp + currentInterval;
      // print("nextSpawn > $nextSpawn");
    }
    super.update(dt);
  }

  //  시작
  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  //  파리 전부 죽이기
  void killAll() {
    flies.forEach((fly) => fly.isDead = true);
  }

  void spawnFly() {
    Fly fly = Fly();
    flies.add(fly);
    add(fly);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    //  크기 및 동일한 위치에 있는 tap이벤트의 경우 부모에서 자식으로 터치가 전파된다 (전파되지 안도록 처리 하는 방안 혹은 순서에 따른 터치가 되지 않도록 처리 하는 방안을 모색해야한다.)
    if (!info.handled) {
      if (gameRef.isHandled) {
        didHitAtFly = false;
        if (gameRef.activeView == View.playing && !didHitAtFly) {
          if (flies.length > 0) {
            flies.forEach((fly) {
            if (fly.isDead) {
              didHitAtFly = true;
            }
            });
            if (gameRef.activeView == View.playing && !didHitAtFly) {
              FlameAudio.play('sfx/haha' + (Random().nextInt(5) + 1).toString() + '.ogg');
              gameRef.isHandled = false;
              gameRef.activeView = View.lost;
              gameRef.handleGameLost();
            }
          }
        }
      }
    }
    return super.onTapDown(info);
  }

}