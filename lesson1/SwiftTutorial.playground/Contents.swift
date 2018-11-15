import UIKit


// 定义变量
var age = 20// 定义变量
age = 21
let name = "Halo" // 定义常亮

// 指定数据类型
let cash: Float = 1.25
let money: Double = 1.252525
let dollar: String = "USD"
let optionalStr: String? = "This is a optional"

// 字符串操作
let currencies = "AUD, " + dollar
let rmb = "1 \(dollar) is 6 RMB"
let formattedString = String(format: "%.2f \(dollar) is about 600 RMB", 100.0)

let introduceSwift = """
We are excited by this new chapter in the story of Swift.
After Apple unveiled the Swift programming language, it quickly became one of
the fastest growing languages in history. Swift makes it easy to write software
that is incredibly fast and safe by design. Now that Swift is open source, you can
help make the best general purpose programming language available everywhere.
"""

// 元组
let numbersTuple = (1, 100, 1000)
print("min: \(numbersTuple.0), max: \(numbersTuple.1), sum: \(numbersTuple.2)")

let numbersNamedTuple = (min: 1, max: 100, sum: 1000)
print("min: \(numbersNamedTuple.0), max: \(numbersNamedTuple.1), sum: \(numbersNamedTuple.2)")
print("min: \(numbersNamedTuple.min), max: \(numbersNamedTuple.max), sum: \(numbersNamedTuple.sum)")

// 集合
var fruits = ["apple", "banana", "oranage"]
fruits[0] = "tomato"
fruits

var pets = Array(arrayLiteral: "cat", "dog", "duck")

var fruitsPrice = [
  "apple": 4.25,
  "banana": 6.2
]
fruitsPrice["apple"]

var emptyArray = [String]()
var emptyDictionary = [String: Float]()

var emptyArray2: [String] = []
var emptyDictionary2: [String: Float] = [:]

//let prices = fruits.map { fruit in
//  return fruitsPrice[fruit]
//}
//
//let _ = [[1, 2], [3]]
//  .flatMap { $0 }
//
//let _ = fruits.compactMap { fruit in
//  return fruitsPrice[fruit]
//}

// Optional
var value: String = "value"
var optionalValue: String? = nil
print(optionalValue ?? value)

if let value = optionalValue {
  print(value)
}

//guard let value = optionalValue else {
//  Handle error
//  throw NSError(domain: "", code: 1, userInfo: nil)
//}
//print(value)

// Casting
let any: Any = 5
let intNumber = any as? Int
let doubleNumber = any as? Double

// 函数
// 参数名即标签
func greet(person: String, day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet(person: "Andy", day: "Friday")

// 使用“_”表示无参数label，也可以单独指定
func greet(_ person: String, on day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet("Andy", on: "Friday")

// Closure
func hasAnyMatches(_ list: [Int], matcher: (Int) -> Bool) -> Bool {
  for item in list {
    if matcher(item) {
      return true
    }
  }
  
  return false
}

hasAnyMatches([1, 2, 3], matcher: { number in
  return number > 0
})

// 与上面写法等价
hasAnyMatches([1, 2, 3]) { number in
  return number > 0
}

// 省略 () 如果 Closure 是唯一的参数
let sortedNumbers = [20, 10, 7, 12].sorted { $0 > $1 }

// class，struct
class Shape {
  let numberOfSides: Int
  
  init(numberOfSides: Int) {
    self.numberOfSides = numberOfSides
  }
  
  func simpleDescription() -> String {
    return "A shape with \(numberOfSides) sides."
  }
}

let shape = Shape(numberOfSides: 10)
shape.simpleDescription()

class Triangle: Shape {
  init() {
    super.init(numberOfSides: 3)
  }
}

let triangle = Triangle()
triangle.simpleDescription()

// Protocol
protocol ExampleProtocol {
  var simpleDescription: String { get }
  func adjust()
}

class SimpleClass: ExampleProtocol {
  var simpleDescription: String = "A simple class."
  var moreProperty: Int = 315
  func adjust() {
    simpleDescription += " Now 100% adjusted"
  }
}

var simpleClass = SimpleClass()
simpleClass.adjust()
print(simpleClass.simpleDescription)
