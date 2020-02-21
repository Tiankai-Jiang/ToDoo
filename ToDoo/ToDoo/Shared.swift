import Foundation

class Shared{
    static let sharedInstance = Shared()
    var habits = [Habit]()
    var selectedDays = [Bool]()
}
