import UIKit

class Shared{
    static let sharedInstance = Shared()
    var habits = [Habit]()
    var selectedDays = [Bool]()
    var profileImage: UIImage = #imageLiteral(resourceName: "default_avatar")
    var botImage: UIImage = #imageLiteral(resourceName: "default_avatar")
    var userName: String = "Master"
    var botName: String = "ChatBot"
}
