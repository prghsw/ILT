import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:langaw/components/credits.dart';
import 'package:langaw/components/help.dart';
import 'package:langaw/components/score-display.dart';
import 'package:langaw/components/start-button.dart';
import 'package:langaw/constollers/spawner.dart';
import 'package:langaw/views/lost-view.dart';
import 'components/backyard.dart';
import 'package:langaw/view.dart';
import 'package:flame/game.dart';
import 'views/home-view.dart';
import 'dart:ui';

class LangawGame extends FlameGame with HasTappables {
  // final List<Fly> _flies = [];
  late Backyard backyard; //  백그라운드 이미지
  late HomeView homeView; //  홈 이미지
  late LostView lostView; //  게임 종료 이미지
  late FlySpawner flySpawner; //  파리 스폰 컴포넌트
  late StartButton startButton;  //  시작 버튼
  late Help help; //  도움말 컴포넌트
  late Credits credits;  //  크레딧 컴포넌트
  late ScoreDisply scoreDisplay;  //  스코어 컴포넌트
  View activeView = View.home;  //  게임 상태
  // List<Fly> flies = []; //  생성된 파리 개체 목록
  bool didHitAFly = false;
  bool isHandled = false;  //  컴포넌트 클릭 처리 관련. 컴포넌트가 클릭 되면 처리 중으로 표시하여 다른 행동 못하도록 한다.
  int score = 0;  //  점수
  late AudioPlayer homeBGM;
  late AudioPlayer playingBGM;

  @override
  bool debugMode = true;

  //  비동기 초기화 코드 사용
  @override
  Future<void> onLoad() async {
    super.onLoad();
    //  백그라운드 추가.
    backyard = Backyard();
    add(backyard);

    //  파리 스폰 컨트롤러 추가.
    flySpawner = FlySpawner();
    add(flySpawner);
    
    // 타이틀 추가.
    homeView = HomeView();
    add(homeView);

    //  시작 버튼 추가.
    startButton = StartButton();
    add(startButton);

    //  도움말 추가.
    help = Help();
    add(help);

    //  크레딧 버튼 추가.
    credits = Credits();
    add(credits);

    //  스코어 컴포넌트 생성
    scoreDisplay = ScoreDisply();

    //  게임오버 화면
    lostView = LostView();

    // this.spawnFly();  //  파리 생성

    homeBGM = await FlameAudio.loop('bgm/home.mp3', volume: .25);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() async {
    playingBGM = await FlameAudio.loop('bgm/playing.mp3', volume: .25);
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

  //  화면 탭시 handle 처리
  // @override
  // void onTapDown(int pointerId, TapDownInfo info) {
  //   print("?");
  //   info.handled = isHandled;
  //   super.onTapDown(pointerId, info);
  // }

  //  플레이 화면 구성
  void handlePlaying() {
    score = 0;

    remove(startButton);
    remove(credits);
    remove(help);
    
    if (activeView != View.lost) {
      remove(homeView);
    } else {
      remove(lostView);
    }

    flySpawner.add(scoreDisplay);
    flySpawner.start();
    activeView = View.playing;
    playPlayingBGM();
  }

  //  HOME 화면 구성
  void handleHome() {
    //  파리 스포너 추가.
    add(flySpawner);
    //  타이틀 추가.
    add(homeView);
    //  시작버튼 추가.
    add(startButton);
  }

  //  도움말 화면 구성
  void handleHelp() {
    if (activeView == View.home) {
      handleHome();
      add(credits);
    } else {
      if (lostView.isMounted) {
        remove(lostView);
      }
      if (homeView.isMounted) {
        remove(homeView);
      }
      remove(flySpawner);
      remove(startButton);
      remove(credits);
    }
  }

  //  크레딧 화면 구성
  void handleCredit() {
    if (activeView == View.home) {
      handleHome();
      add(help);
    } else {
      if (lostView.isMounted) {
        remove(lostView);
      }
      if (homeView.isMounted) {
        remove(homeView);
      }
      remove(flySpawner);
      remove(startButton);
      remove(help);
    }
  }

  void handleGameLost() {
    flySpawner.remove(scoreDisplay);
    add(lostView);
    add(startButton);
    add(help);
    add(credits);
    playHomeBGM();
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