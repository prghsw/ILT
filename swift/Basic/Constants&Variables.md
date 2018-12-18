
Constants and Variables (변수와 상수)
------------------------------------

1. 변수(Variables)
<pre>
 - 변수는 값을 수정 할 수 있다.
 - 변수는 var 으로 선언
</pre>
2. 상수(Constant)
<pre>
 - 상수는 값을 수정 할 수 없다.
 - 상수는 let 으로 선언
</pre>
* swift는 변수 보다는 상수를 권장한다.

###  * 예제

* 변수 예제
<pre>
  var val1 = "헬로~ 시드니~ o0o"
  val1 = "누구세요????? ?_?"
  
  var val2 = "헬로~", val3 = "시드니~", val4 = "o0o"
  val2 = "누구"
  val3 = "세요"
  val4 = "????? ?_?"
</pre>

* 상수 예제
<pre>
  let val1 = "헬로~ 시드니~ o0o"
  val1 = "누구세요????? ?_?" ! Cannot assign to value: 'val1' is a 'let' constant
  
  let val2 = "헬로~", val3 = "시드니~", val4 = "o0o"
  val2 = "누구" ! Cannot assign to value: 'val2' is a 'let' constant
  val3 = "세요" ! Cannot assign to value: 'val3' is a 'let' constant
  val4 = "?????"  ! Cannot assign to value: 'val4' is a 'let' constant
</pre>
