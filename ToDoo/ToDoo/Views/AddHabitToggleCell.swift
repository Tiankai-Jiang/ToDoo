import UIKit
import UserNotifications

class AddHabitToggleCell: UITableViewCell {

    
    @IBOutlet weak var toggle: UISwitch!
    @IBAction func switchView(_ sender: UISwitch) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if(granted){
                print("user granted")
            }
        }
        (viewController(forView: self.tableView!) as! AddHabitViewController).timePicker.isHidden = !sender.isOn
        (viewController(forView: self.tableView!) as! AddHabitViewController).isNotificationOn = sender.isOn
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
