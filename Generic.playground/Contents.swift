import Foundation

/// Part. 1
/// T 由外部決定 第一個範例
func outterGeneric<T>() -> T? {
    return 1 as? T
}

let aInt:Int? = outterGeneric()



/// Part. 2
/// 把 data 包入 struct
struct GenericStruct {
    let data:Any
    func decode<T>() -> T? {
        return data as? T
    }
}

let theHello = GenericStruct(data: "hello")
let the123 = GenericStruct(data: 123)

let stringHello:String? = theHello.decode()
let intHello:Int? = theHello.decode()
let int123:Int? = the123.decode()
let string123:String? = the123.decode()

/// Part. 2 題外話
/// init or function 也可以決定 T 的型態
struct Course {
    let name:String?
    let score:Int?
}

// 單純的 struct 會有預設 init method
// Course.init(name: <#T##String?#>, score: <#T##Int?#>)
// Course(name: <#T##String?#>, score: <#T##Int?#>)
let math = Course(
    name: GenericStruct(data: "Math").decode(),
    score: GenericStruct(data: 100).decode()
)
math.name
math.score


/// Part.3
/// 搭配 protocol 轉回改有的型態
protocol FakeProtocol{}
extension String:FakeProtocol{}
extension Int:FakeProtocol{}

extension GenericStruct {
    func decodeFromProtocol<T:FakeProtocol>() -> T? {
        return data as? T
    }
    
    func decodeToInt() -> Int? {
        return self.decodeFromProtocol()
    }
    
    func decodeToString() -> String? {
        return self.decodeFromProtocol()
    }
}

theHello.decodeToString()
theHello.decodeToInt()
the123.decodeToInt()
the123.decodeToString()
