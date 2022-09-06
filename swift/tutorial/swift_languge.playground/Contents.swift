
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

//  Operators
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

