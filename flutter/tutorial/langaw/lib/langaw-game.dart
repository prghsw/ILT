import 'package:langaw/components/help-button.dart';
import 'package:langaw/components/start-button.dart';
import 'package:langaw/constollers/spawner.dart';
import 'package:langaw/views/lost-view.dart';

import 'components/fly.dart';
import 'components/backyard.dart';
import 'package:langaw/view.dart';
import 'package:flame/game.dart';
import 'views/home-view.dart';
import 'dart:ui';

class LangawGame extends FlameGame with HasTappables {
  // final List<Fly> _flies = [];
  Backyard backyard = Backyard(); //  백그라운드 이미지
  HomeView homeView = HomeView(); //  홈 이미지
  LostView lostView = LostView(); //  게임 종료 이미지
  FlySpawner flySpawner = FlySpawner(); //  파리 스폰 컴포넌트
  StartButton startButton = StartButton();  //  시작 버튼
  HelpButton helpButton = HelpButton(); //  도움말 버튼
  View activeView = View.home;  //  게임 상태
  // List<Fly> flies = []; //  생성된 파리 개체 목록
  bool didHitAFly = false;

  @override
  bool debugMode = true;

  //  비동기 초기화 코드 사용
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(backyard);
    add(homeView);
    add(helpButton);
    add(startButton);
    add(flySpawner);
    // this.spawnFly();  //  파리 생성
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    if (activeView == View.playing && !didHitAFly) {
      activeView = View.lost;
    }

    // if (activeView == View.lost) {
    //   if (!lostView.isMounted) {
    //     _handleGameLost();
    //   }
    // }
    super.update(dt);
  }

  void _handleGameLost() {
    add(lostView);
  }

  //  백그라운드 변경
  // @override
  // Color backgroundColor() => const Color(0xff576574);

  //  컴포넌트 스폰 처리
  // void spawnFly() {
  //   print("files > ${flies.length}");
  //   Fly newFly = Fly();
  //   flies.add(newFly);
  //   add(newFly);
  // }

}