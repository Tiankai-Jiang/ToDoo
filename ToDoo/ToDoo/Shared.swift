import UIKit

class Shared{
    static let sharedInstance = Shared()
    var habits = [Habit]()
    var selectedDays = [Bool]()
    var profileImage: UIImage = #imageLiteral(resourceName: "profile_woman")
    var botImage: UIImage = #imageLiteral(resourceName: "profile_man")
    var userName: String = "Master"
    var botName: String = "ChatBot"
}
