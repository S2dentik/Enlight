import Foundation

struct Struct {
    let string: String
    let data: Data
    let int: Int
    let double: Double
    let other: Other
    let someClass: Class
}

struct Other {
    let float: Float
    let bool: Bool
}

class Class {
    let other: Other
    let someStruct: Struct
}
