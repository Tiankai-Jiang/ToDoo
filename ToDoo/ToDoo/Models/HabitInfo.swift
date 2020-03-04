import Foundation

enum infoTypes{
    case total
    case current
    case longest
    case established
    case missed
}

struct HabitInfo{
    let infoName: String
//    let infoType: infoTypes
    let info: String
}
