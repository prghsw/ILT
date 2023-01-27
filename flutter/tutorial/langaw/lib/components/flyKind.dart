enum FlyKind {
  house(["flies/house-fly-1.png",
    "flies/house-fly-2.png"],
    "flies/house-fly-dead.png",
    1.5,
    3),
  drooler(["flies/drooler-fly-1.png", "flies/drooler-fly-2.png"],
    "flies/drooler-fly-dead.png",
    1.5,
    1.5),
  agile(["flies/agile-fly-1.png", "flies/agile-fly-2.png"],
    "flies/agile-fly-dead.png",
    1.5,
    5),
  macho(["flies/macho-fly-1.png", "flies/macho-fly-2.png"],
    "flies/macho-fly-dead.png",
    2.025,
    2.5),
  hungry(["flies/hungry-fly-1.png", "flies/hungry-fly-2.png"],
    "flies/hungry-fly-dead.png",
    1.65,
    3);

  //  생성자
  const FlyKind(this.alive, this.dead, this.size, this.speed);

  // 이미지 목록
  final List<String> alive; //  살아있는 애니메이션
  final String dead;        //  죽은 애니메이션
  //  종류별 상세 정보
  final double size;      //  컴포넌트 별 크기
  final double speed;     //  컴포넌트 속도

}