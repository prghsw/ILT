


import 'package:flame/components.dart';
import 'package:langaw/langaw-game.dart';

import '../components/fly.dart';

//  파리 스폰 컴포넌트
class FlySpawner extends PositionComponent with HasGameRef<LangawGame> {
  final int maxSpawnInterval = 3000;  //  최대 스폰 지연 시간
  final int minSpawnInterval = 250;   //  최소 스폰 지연 시간
  final int intervalChange = 3;       //  지연시간 변경
  final int maxFliesOnScreen = 7;     //  최대 파리 수
  late int currentInterval;           //  현재 지연 시간
  late int nextSpawn;                 //  다음 스폰 시간
  List<Fly> flies = [];               //  생성된 파리 목록

  //  비동기 초기화 코드
  @override
  Future<void> onLoad() async {
    //  시작
    start();
    //  최초 파리 스폰
    this.spawnFly();
  }

  @override
  void update(double dt) {
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

}