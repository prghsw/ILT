
/*
 Swift Optional
    - 기본 값은 nil
    - var, let 값이 없는 변수 선언 할때 사용.
    - 값을 포함하거나 없을 수 있음 (null 값)
    - 타입에 ! 혹은 ? 를 붙여 Optional을 표현한다.
 */

//  Optional 선언
var intValue: Int?
var intValue2: Int!
print(intValue)
print(intValue2)

// ? 와 ! 차이점
/*
    ? 를 사용하면 Optional<Value> 로 묶인다.
    <Value>에 접근 하기 위해서는 기술적으로 풀어서 사용해야한다.
    풀기 위해서는 !를 사용하면 된다.
    ! 의 경우 변수에 접근할 값이 있는 경우에만 사용해야한다.
 */
var intVarQm: Int? = 5
let intLetQm: Int? = 5
print(intVarQm)
print(intVarQm!)
print(intLetQm)
print(intLetQm!)

//  사이트에서 설명하는 것과 다름. !를 설정하여 변수 초기화 하는 경우 unwrapped optional 이라고 했지만 optional로 감싸짐.
let intVarUnWrapped: Int! = 5
print(intVarUnWrapped)

var intValue3: Int!
//var unrappedValue1: Int = intValue3
// fatal error : unexpectedly found nil while unwrapping an Optional value 발생.
// unwrapped 된 값에 optional, nil을 할당할 수 없음.

//  # Optional Handling
// if-statement
var someValue: Int?
var someAnotherValue: Int! = 0

if someValue != nil {
    print("It has some value \(someValue!)")
} else {
    print("doesn't contain value")
}

if someAnotherValue != nil {
    print("It has some value \(someAnotherValue!)")
} else {
    print("doesn't contain value")
}

//  Optional Binding (if-let / if-var)
//  옵셔널 바인딩은 값이 있는지 없는지 확인 할 수 있다.
//  값이 존재하면 let, var 임시 변수를 사용 할 수 있다.
//  if 구문과 함께 사용 된다.
var optionalBindingVar: Int?
var optionalBindingVar2: Int! = 0

if var temp = optionalBindingVar {
    print("It has some value \(temp)")
} else {
    print("dosen't contain value")
}
if let temp = optionalBindingVar {
    print("It has some value \(temp)")
} else {
    print("dosen't contain value")
}

if var temp = optionalBindingVar2 {
    print("It has some value \(temp)")
} else {
    print("dosen't contain value")
}
if let temp = optionalBindingVar2 {
    print("It has some value \(temp)")
} else {
    print("dosen't contain value")
}

//  Guard 구문
/*
    옵셔널을 처리하기 위해 guard를 사용한다.
    조건이 실패하면 else 구문이 실행된다. 그게 아니면, 다음 구문이 실행된다.
 */
func testFunction() {
    let guardValue:Int? = 5
    var guardValue2: Int?
    guard let temp = guardValue else {
        print("dosen't contain value of temp")
        return
    }
    print("It has some value of temp \(temp)")
    
    guard var temp2 = guardValue2 else {
        print("dosen't contain value of temp2")
        return
    }
    print("It has some value of temp2 \(temp2)")
}

testFunction()

//  Nil-coalescing operator
/*
    값을 포함하는지 하지 않는지 확인 하기 위해 사용 한다.
    (a ?? b) 로 정의 한다.
    값이 존재하면 옵셔널을 해제한 a를 반환하거나, 없으면 b를 기본값으로 반환한다.
 */
var nilCoalescingValue: Int!
let nilCalescingDefaultValue = 5
let nilCalescingUnwrappedValue: Int = nilCoalescingValue ?? nilCalescingDefaultValue
print("nil-coalescing > \(nilCoalescingValue)")
print("nil-coalescing > \(nilCalescingUnwrappedValue)")

var nilCoalescingValue2: Int? = 10
let nilCoalescingDefaultValue2 = 5
let nilCoalescingUnwrappedValue2: Int = nilCoalescingValue2 ?? nilCoalescingDefaultValue2
print("nil-coalescing > \(nilCoalescingValue2)")
print("nil-coalescing > \(nilCoalescingUnwrappedValue2)")

// Arithmetic Operators
/*
    + : Addition
    - : Subtraction
    * : Multiplication
    / : Division
    % : Modulo
 */
var a = 7
var b = 2
print(a+b)
print(a-b)
print(a*b)
//  integer를 나누기 하면 integer 값이 나옴.
print(a/b)
var aD:Float = 7.0
var bD:Float = 3.0
print(aD/bD)
print(9%4)

//  Assignmen Operators
/*
    =   Assingment Operator
    +=  Addition Assignment Operator
    -=  Subtraction Assignment
    *=  Multiplication Assignment
    /=  Division Assignment
    %=  Remainder Assignment
 */
var aa = 10
var bb = 5

aa += bb
print(aa)

//  Comparison Operators
/*
    ==  Is Equal To
    !=  Not Equal To
    >   Greater Than
    <   Less Than
    >=  Greater Than or Equal To
    <=  Less Than or Equal To
 */
var aaa = 5, bbb = 2
print(aaa == bbb)
print(aaa != bbb)
print(aaa > bbb)
print(aaa < bbb)
print(aaa >= bbb)
print(aaa <= bbb)

//  Logical Operators
/*
    &&  Logical AND
    ||  Logical OR
    !   Logical NOT
 */

print(true && true)
print(true && false)
print(true || false)
print(!true)

//  Bitwise Operators
/*
    &   Binary AND
    |   Binary OR
    ^   Binary XOR
    ~   Binary One's Complement
    <<  Binary Shift Left
    >>  Binary Shift Right
 */

//  Other Swift Operators
/*
    ? :     Ternary Operator (삼항연산자)
    ??      Nil-Coalescing Operator (옵셔널 값 확인 및 기본값 설정)
    ...     Range Operator  (길이 연산자)    ex) 1...3 -> 1,2,3
 */

//  Swift Operator 선행 및 결합
var num = 8 + 5 * 4
//  1. * 2. + 순서로 실행 된다.

/*
    연산자 우위 (precedencs) 테이블
    1. Bitwise shift        >>  <<
    2. Multiplicative       %   *   /
    3. Additive             |   -   +   -   ^
    4. Range                ..<     ...
    5. Casting              is  as
    6. Nil-Coalescing       ??
    7. Comparison           !=  >   <   >=  <=  === ==
    8. Logical AND          &&
    9. Logical OR           ||
    10. Ternary Operator    ? :
    11. Assignment Precedence   |=  %=  /=  *=  >>= <<= ^=  +=  -=
 */
var precedenceNum = 15
precedenceNum += 10 - 2 * 3
//  1. *    2. -    3. +=

//  Swift Operator 결합
//  precedence (우위)가 같으면 왼쪽에서 오른쪽 혹은 오른쪽에서 왼쪽 으로 계산된다.
print(6 * 4 / 3)
//  1. *    2. / (왼쪽에서 오른쪽)

//  연산자 결합 테이블
/*
    - Left > left to right
    - Right > right to left
    - None > no defined behavior
    Bitwise Shift       >   none
    Multiplicative      >   left
    Additive            >   left
    Range               >   none
    Casting             >   none
    Nil-Coalescing      >   right
    Comparison          >   none
    Logical AND         >   left
    Logical OR          >   left
    Ternary Operator    >   right
    Assignment          >   right
 */


//  Ternary Operator in Swift
//  condition ? expression1 : expression2
//  if condition is true, expression1
//  if condition is false, expression2

let marks = 60
let result = (marks >= 40) ? "pass" : "fail"

print("You \(result) the exam")

//  Ternary operator instead of if...else
let toNum = 15
var toResult = ""

if (toNum > 0) {
    toResult = "Positive Number"
} else {
    toResult = "Negative Number"
}

print(toResult)

let toNum1 = 15
let toResult1 = (toNum1 > 0) ? "Positive Number" : "Negative Number"
print(toResult1)

//  Nested Ternary Operators
let ntoNum = 7
let ntoResult = (ntoNum == 0) ? "Zero" : ((num > 0) ? "Positive" : "Negative")
print("The number is \(ntoResult)")

//  Swift Bitwise and Bit Shift Operators
//  Bitwise AND Operator
var andA = 12
var andB = 25
var andResult = a & b
print(andResult)
