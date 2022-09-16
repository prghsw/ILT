
///*
// Swift Optional
//    - 기본 값은 nil
//    - var, let 값이 없는 변수 선언 할때 사용.
//    - 값을 포함하거나 없을 수 있음 (null 값)
//    - 타입에 ! 혹은 ? 를 붙여 Optional을 표현한다.
// */
//
////  Optional 선언
//var intValue: Int?
//var intValue2: Int!
//print(intValue)
//print(intValue2)
//
//// ? 와 ! 차이점
///*
//    ? 를 사용하면 Optional<Value> 로 묶인다.
//    <Value>에 접근 하기 위해서는 기술적으로 풀어서 사용해야한다.
//    풀기 위해서는 !를 사용하면 된다.
//    ! 의 경우 변수에 접근할 값이 있는 경우에만 사용해야한다.
// */
//var intVarQm: Int? = 5
//let intLetQm: Int? = 5
//print(intVarQm)
//print(intVarQm!)
//print(intLetQm)
//print(intLetQm!)
//
////  사이트에서 설명하는 것과 다름. !를 설정하여 변수 초기화 하는 경우 unwrapped optional 이라고 했지만 optional로 감싸짐.
//let intVarUnWrapped: Int! = 5
//print(intVarUnWrapped)
//
//var intValue3: Int!
////var unrappedValue1: Int = intValue3
//// fatal error : unexpectedly found nil while unwrapping an Optional value 발생.
//// unwrapped 된 값에 optional, nil을 할당할 수 없음.
//
////  # Optional Handling
//// if-statement
//var someValue: Int?
//var someAnotherValue: Int! = 0
//
//if someValue != nil {
//    print("It has some value \(someValue!)")
//} else {
//    print("doesn't contain value")
//}
//
//if someAnotherValue != nil {
//    print("It has some value \(someAnotherValue!)")
//} else {
//    print("doesn't contain value")
//}
//
////  Optional Binding (if-let / if-var)
////  옵셔널 바인딩은 값이 있는지 없는지 확인 할 수 있다.
////  값이 존재하면 let, var 임시 변수를 사용 할 수 있다.
////  if 구문과 함께 사용 된다.
//var optionalBindingVar: Int?
//var optionalBindingVar2: Int! = 0
//
//if var temp = optionalBindingVar {
//    print("It has some value \(temp)")
//} else {
//    print("dosen't contain value")
//}
//if let temp = optionalBindingVar {
//    print("It has some value \(temp)")
//} else {
//    print("dosen't contain value")
//}
//
//if var temp = optionalBindingVar2 {
//    print("It has some value \(temp)")
//} else {
//    print("dosen't contain value")
//}
//if let temp = optionalBindingVar2 {
//    print("It has some value \(temp)")
//} else {
//    print("dosen't contain value")
//}
//
////  Guard 구문
///*
//    옵셔널을 처리하기 위해 guard를 사용한다.
//    조건이 실패하면 else 구문이 실행된다. 그게 아니면, 다음 구문이 실행된다.
// */
//func testFunction() {
//    let guardValue:Int? = 5
//    var guardValue2: Int?
//    guard let temp = guardValue else {
//        print("dosen't contain value of temp")
//        return
//    }
//    print("It has some value of temp \(temp)")
//
//    guard var temp2 = guardValue2 else {
//        print("dosen't contain value of temp2")
//        return
//    }
//    print("It has some value of temp2 \(temp2)")
//}
//
//testFunction()
//
////  Nil-coalescing operator
///*
//    값을 포함하는지 하지 않는지 확인 하기 위해 사용 한다.
//    (a ?? b) 로 정의 한다.
//    값이 존재하면 옵셔널을 해제한 a를 반환하거나, 없으면 b를 기본값으로 반환한다.
// */
//var nilCoalescingValue: Int!
//let nilCalescingDefaultValue = 5
//let nilCalescingUnwrappedValue: Int = nilCoalescingValue ?? nilCalescingDefaultValue
//print("nil-coalescing > \(nilCoalescingValue)")
//print("nil-coalescing > \(nilCalescingUnwrappedValue)")
//
//var nilCoalescingValue2: Int? = 10
//let nilCoalescingDefaultValue2 = 5
//let nilCoalescingUnwrappedValue2: Int = nilCoalescingValue2 ?? nilCoalescingDefaultValue2
//print("nil-coalescing > \(nilCoalescingValue2)")
//print("nil-coalescing > \(nilCoalescingUnwrappedValue2)")
//
//// Arithmetic Operators
///*
//    + : Addition
//    - : Subtraction
//    * : Multiplication
//    / : Division
//    % : Modulo
// */
//var a = 7
//var b = 2
//print(a+b)
//print(a-b)
//print(a*b)
////  integer를 나누기 하면 integer 값이 나옴.
//print(a/b)
//var aD:Float = 7.0
//var bD:Float = 3.0
//print(aD/bD)
//print(9%4)
//
////  Assignmen Operators
///*
//    =   Assingment Operator
//    +=  Addition Assignment Operator
//    -=  Subtraction Assignment
//    *=  Multiplication Assignment
//    /=  Division Assignment
//    %=  Remainder Assignment
// */
//var aa = 10
//var bb = 5
//
//aa += bb
//print(aa)
//
////  Comparison Operators
///*
//    ==  Is Equal To
//    !=  Not Equal To
//    >   Greater Than
//    <   Less Than
//    >=  Greater Than or Equal To
//    <=  Less Than or Equal To
// */
//var aaa = 5, bbb = 2
//print(aaa == bbb)
//print(aaa != bbb)
//print(aaa > bbb)
//print(aaa < bbb)
//print(aaa >= bbb)
//print(aaa <= bbb)
//
////  Logical Operators
///*
//    &&  Logical AND
//    ||  Logical OR
//    !   Logical NOT
// */
//
//print(true && true)
//print(true && false)
//print(true || false)
//print(!true)
//
////  Bitwise Operators
///*
//    &   Binary AND
//    |   Binary OR
//    ^   Binary XOR
//    ~   Binary One's Complement
//    <<  Binary Shift Left
//    >>  Binary Shift Right
// */
//
////  Other Swift Operators
///*
//    ? :     Ternary Operator (삼항연산자)
//    ??      Nil-Coalescing Operator (옵셔널 값 확인 및 기본값 설정)
//    ...     Range Operator  (길이 연산자)    ex) 1...3 -> 1,2,3
// */
//
////  Swift Operator 선행 및 결합
//var num = 8 + 5 * 4
////  1. * 2. + 순서로 실행 된다.
//
///*
//    연산자 우위 (precedencs) 테이블
//    1. Bitwise shift        >>  <<
//    2. Multiplicative       %   *   /
//    3. Additive             |   -   +   -   ^
//    4. Range                ..<     ...
//    5. Casting              is  as
//    6. Nil-Coalescing       ??
//    7. Comparison           !=  >   <   >=  <=  === ==
//    8. Logical AND          &&
//    9. Logical OR           ||
//    10. Ternary Operator    ? :
//    11. Assignment Precedence   |=  %=  /=  *=  >>= <<= ^=  +=  -=
// */
//var precedenceNum = 15
//precedenceNum += 10 - 2 * 3
////  1. *    2. -    3. +=
//
////  Swift Operator 결합
////  precedence (우위)가 같으면 왼쪽에서 오른쪽 혹은 오른쪽에서 왼쪽 으로 계산된다.
//print(6 * 4 / 3)
////  1. *    2. / (왼쪽에서 오른쪽)
//
////  연산자 결합 테이블
///*
//    - Left > left to right
//    - Right > right to left
//    - None > no defined behavior
//    Bitwise Shift       >   none
//    Multiplicative      >   left
//    Additive            >   left
//    Range               >   none
//    Casting             >   none
//    Nil-Coalescing      >   right
//    Comparison          >   none
//    Logical AND         >   left
//    Logical OR          >   left
//    Ternary Operator    >   right
//    Assignment          >   right
// */
//
//
////  Ternary Operator in Swift
////  condition ? expression1 : expression2
////  if condition is true, expression1
////  if condition is false, expression2
//
//let marks = 60
//let result = (marks >= 40) ? "pass" : "fail"
//
//print("You \(result) the exam")
//
////  Ternary operator instead of if...else
//let toNum = 15
//var toResult = ""
//
//if (toNum > 0) {
//    toResult = "Positive Number"
//} else {
//    toResult = "Negative Number"
//}
//
//print(toResult)
//
//let toNum1 = 15
//let toResult1 = (toNum1 > 0) ? "Positive Number" : "Negative Number"
//print(toResult1)
//
////  Nested Ternary Operators
//let ntoNum = 7
//let ntoResult = (ntoNum == 0) ? "Zero" : ((num > 0) ? "Positive" : "Negative")
//print("The number is \(ntoResult)")
//
////  Swift Bitwise and Bit Shift Operators
////  Bitwise AND Operator
//var andA = 12
//var andB = 25
//var andResult = andA & andB
//print(andResult)
//
////  Bitwise OR Operator
//var orA = 12
//var orB = 25
//var orResult = orA | orB
//print(orResult)
//
////  Bitwise XOR Operator
//var xorA = 12
//var xorB = 25
//var xorResult = xorA ^ xorB
//print(xorResult)
//
////  Bitwise NOT Operator
//var notA = 36
//print(~notA)
///*
//    NOT Operator integer N is queal to -(N+1)
//
//    35 > -(35+1) = -36
//
//    NOT 35 > 2진수 표시를 변환하면 220이 된다.
//    하지만 소수내 결과를 직접 변환하여 적절한 결과를 얻을 수 없다.
//    2의 보수를 사용하여 계산해야한다.
//
//    # 2의 보수
//    N의 2의보수는 -N이다.
//    0 > 1 / 1 > 0 변환하고, 1을 추가 한다.
//    36 = 00100100
//    1의 보수 = 11011011
//    2의 보수 = 11011011 + 1 > 11011100
//
// */
//
////  Left Shift Operator
///*
//    << - 왼쪽 이동 연산자
//    bits를 왼쪽으로 하나씩 이동 시키고, 오른쪽을 0으로 채운다.
//                    1 0 1 0
//      Discarded < 1 0 1 0 0 < 0 Replacement Bit
//
//    1. 4자리가 있다. 왼쪽 이동 연산자는 1비트 씩 왼쪽으로 이동 시킨다.
//    2. 맨 왼쪽 비트는 삭제 된다. 맨 오른쪽은 비어지기 때문에 0으로 채운다.
// */
//var lsoA = 3
//var lsoResult = lsoA << 2
////  왼쪽으로 2비트 씩 이동 한다.
//print(lsoResult)
//
////  Right Shift Operator
///*
//    >> - 오른쪽 이동 연산자
//    bits를 오른쪽으로 하나씩 이동 시키고, 오른쪽을 0으로 채운다.
//                        0 0 1 1
//    Replacement Bit 0 > 0 0 0 1 1 > Dicarded
//
//    1. 4자리가 있다. 오른쪽 이동 연산자는 1비트 씩 오른쪽으로 이동 시킨다.
//    2. 맨 오른쪽 비트는 삭제 된다. 맨 왼쪽 비트는 비어지기 때문에 0으로 채운다.
//    3. 부호 있는 숫자는 부호 비트 (양수 0, 음수 1)는 비어 있는 비트 위치를 채우는데 사용 된다.
// */
//var rsoA = 4
//var rsoResult = rsoA >> 2
////  오른쪽으로 2비트 씩 이동 한다.
//print(rsoResult)
//rsoA = -4
//rsoResult = rsoA >> 2
//print(rsoResult)
//
////  if , if...else 구문
////  if 구문
///*
//    if 구문은 괄호 내 조건을 평가 합니다.
//    - 조건이 true 이면 { }의 내부를 실행 합니다.
//    - 조건이 false 이면 { }를 처리 하지 않고 지나 갑니다.
// */
//let ifNumber = 10
//
////  조건이 true > Number is positive 노출
//if (ifNumber > 0) {
//    print("Number is positive")
//}
////  조건이 false > The if statement is easy 노출
//print("The if statement is easy")
//
//// if...else 구문
///*
// if...else 구문
// if가 true이면
//    1. if내 코드를 실행
//    2. else 는 스킵
// if가 false이면
//    1. else 내 코드를 실행
//    2. if 는 스킵
// */
//let ifElseNumber = 10
////let ifElseNumber = -1
//if (ifElseNumber > 0) {
//    print("Number is positive.")
//} else {
//    print("Number is Negative.")
//}
//print("This statement is always excuted.")
//
////  if...else if...else 구문
///*
//    2개 이상의 조건이 필요한 경우 사용한다.
//    1. if가 true이면 if block 실행
//    2. if가 false이면 if else block 확인
//        2-1. if else가 true이면 if else block 실행
//        2-2. if else가 false이면 else block 실행
// */
//let ifElseifElseNumber = 0
//
//if (ifElseifElseNumber > 0) {
//    print("Number is positive.")
//} else if (ifElseifElseNumber < 0) {
//    print("Number is negarive.")
//} else {
//    print("Number is 0.")
//}
//print("This statement is always executed")
//
////  중첩 if 구문
//let nestedIfNumber = 10
//if (nestedIfNumber > 0) {
//    if (nestedIfNumber == 5) {
//        print("half number")
//    }
//}
////  중첩 if...else 구문
//let nestedIfElseNumber = 10
//if (nestedIfElseNumber > 0) {
//    if (nestedIfNumber == 5) {
//        print("half number")
//    } else {
//        print("none half number")
//    }
//}
//
////  switch 구문
//let switchDayOfWeek = 4
//
//switch switchDayOfWeek {
//case 1:
//    print("Sunday")
//case 2:
//    print("Monday")
//case 3:
//    print("Tuesday")
//case 4:
//    print("Wednesday")
//case 5:
//    print("Thursday")
//case 6:
//    print("Friday")
//case 7:
//    print("Saturday")
//default:
//    print("Invalid day")
//}
//
//// switch 구문에서 fallthrough
///*
//    구문내 fallthrough는 일치하는 케이스를 처리하고 다음 케이스가 일치하지 않더라도 처리 한다.
// */
//let fallthrouchDayOfWeek = 4
//
//switch fallthrouchDayOfWeek {
//case 1:
//    print("Sunday")
//case 2:
//    print("Monday")
//case 3:
//    print("Tuesday")
//case 4:
//    print("Wednesday")
//    fallthrough
//case 5:
//    print("Thursday")
//case 6:
//    print("Friday")
//case 7:
//    print("Saturday")
//default:
//    print("Invalid day")
//}
//
////  switch 구문 내 Range
///*
//    Range (...)를 사용하여 사이에 포함 하는 값을 찾아 처리 한다.
// */
//let rangeAgeGroup = 33
//
//switch rangeAgeGroup {
//case 0...16:
//    print("child")
//case 17...30:
//    print("Young Adults")
//case 31...45:
//    print("Middle-aged Adults")
//default:
//    print("Old-aged Adults")
//}
//
////  switch 구문 내 Tuple
//let tupleInfo = ("Dwight", 38)
//
//switch tupleInfo {
//case ("Dwight", 38):
//    print("Dwight is 38 years old")
//case ("Micheal", 46):
//    print("Micheal is 46 years old")
//default:
//    print("Not known")
//}
//
//// for-in 루프
///*
//    for val in sequence {
//        //  statements
//    }
//
//    시퀀스를 각각 접근하며 반복 처리 한다.
//    시퀀스 마지막 아이템까지 접근한다.
// */
//
//let forInlanguages = ["Swift", "Java", "Go", "JavaScript"]
//for language in forInlanguages {
//    print(language)
//}
//
////  for Loop 구문에 where clause
///*
//    for val in sequence where 조건 {
//        //  statements
//    }
//
//    시퀀스를 각각 접근 하며 조건에 맞는 것만 반복 처리 한다.
// */
//for language in forInlanguages where language != "JAVA" {
//    print(language)
//}
//
////  for Loop 구문에 Range (...)
///*
//    for i in 1...3 {
//        // statements
//    }
// */
//var rangeValues = 1...3
//for i in rangeValues {
//    print(i)
//}
//
//for i in 1...3 {
//    print(i)
//}
//
////  for Loop 구문에 stride(from:to:by)
///*
//    for i in stride(from: 1, to: 10, by: 2) {
//        //  statements
//    }
//
//    from > to 까지 반복하며 처리하지만, by만큼 증가 하며 처리한다.
// */
//for i in stride(from: 1, to: 10, by: 2) {
//    print(i)
//}
//
//// while 구문
///*
//    조건이 false가 될때까지 반복한다.
// */
//var whileI = 1, whileN = 5
//
//while (whileI <= whileN) {
//    print(whileI)
//    whileI = whileI + 1
//}
//
////  repeat...while 구문
///*
//    코드를 한번 실행 시키고 난 후 조건이 false가 될때까지 반복한다.
// */
//var repeatWhileI = 1, repeatWhileN = 5
//repeat {
//    print(repeatWhileI)
//    repeatWhileI = repeatWhileI + 1
//} while(repeatWhileI <= repeatWhileN)
//
////  무한 반복
///*
//while(true) {
//
//}
// */
//
////  중첩 for in 구문
//for week in 1...2 {
//    print("Week : \(week)")
//    for day in 1...7 {
//        print(" Day: \(day)")
//    }
//    print("end")
//}

/*
 while(condition) {
    while(condition) {
 
    }
 }
 */

//  while 루프 내 for 루프
//var whileForWeeks = 2
//var whileForWeeksI = 1
//
//while (whileForWeeksI <= whileForWeeks) {
//    print("week : \(whileForWeeksI)")
//
//    for day in 1...7 {
//        print(" Day : \(day)")
//    }
//
//    whileForWeeksI = whileForWeeksI + 1
//}


/*
    중첩 Loop에서 braek and continue
 */

//  break

//for week in 1...3 {
//    print("Week : \(week)")
//
//    for day in 1...7 {
//        if week == 2 {
//            break
//        }
//
//        print(" Day : \(day)")
//    }
//
//    print("")
//}

//  continue
//for week in 1...2 {
//    print("Week : \(week)")
//
//    for day in 1...7 {
//        if day % 2 != 0 {
//            continue
//        }
//        print("     Day : \(day)")
//    }
//
//    print("")
//}

/*
    for 루프와 break
 */

//for i in 1...5 {
//    if i == 3 {
//        break   //   for 문을 빠져 나간다.
//    }
//    print(i)
//}

/*
    while 루프와 break
 */
//var whileBreakI = 1
//while whileBreakI <= 10 {
//    print("6 * \(whileBreakI) =", 6*whileBreakI)
//
//    if whileBreakI >= 5 {
//        break   //  while 문을 빠져 나간다.
//    }
//    whileBreakI = whileBreakI + 1
//}

/*
    중첩 Loop와 break
 */
for i in 1...3 {
    for j in 1...3 {
        if 1 == 2 {
            break   //  j (for) 문을 빠져 나간다.
        }
        print("i = \(i), j = \(j)")
    }
    // break문을 만나면 여기로 온다.
}

/*
    Labeled break
 */
outerLoop: for i in 1...3 {
    innerLoop: for j in 1...3 {
        if j == 3 {
            break outerLoop //  outerLoop를 빠져 나간다.
        }
        
        print("i = \(i), j = \(j)")
    }
}
// break를 만나면 여기로 온다.

/*
    for loop와 continue
 */
for i in 1...5 {
    if i == 3 {
        continue    //  
    }
    print(i)
}

