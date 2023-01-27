
import 'package:flame/components.dart';

//  백그라운드 컴포넌트
class Backyard extends SpriteComponent with HasGameRef {
  
  //  비동기 초기화 처리.
  @override
  Future<void>? onLoad() async {
    //  sprite 이미지 가져오기 (초기 로딩 혹은 Flame.images 캐싱 정보 가져오기)
    sprite = await Sprite.load('bg/backyard.png');
    //  디바이스 크기 만큼 지정
    size = gameRef.size;
    return super.onLoad();
  }

}