import Foundation

struct Habit{
    let name: String
    let ifRemind: Bool
    let remindDays: [Bool]
    let notificationTime: Int
    let color: String
    let todayStatus: Bool
    var checkedDays: [String: Int] = [:]
    
    init(name: String, ifRemind: Bool, remindDays: [Bool], notificationTime: Int, color: String, todayStatus: Bool){
        self.name = name
        self.ifRemind = ifRemind
        self.remindDays = remindDays
        self.notificationTime = notificationTime
        self.color = color
        self.todayStatus = todayStatus
    }
}
